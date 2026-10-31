import base64
from concurrent.futures import ThreadPoolExecutor
from PySide6.QtCore import QObject, Signal, Property, Slot, QTimer

try:
    import winrt.windows.media.control as wmc
    import winrt.windows.storage.streams as streams
    HAS_WINRT = True
except Exception:
    HAS_WINRT = False

import sys


class MediaService(QObject):
    mediaChanged = Signal()
    _stateReceived = Signal(dict)

    def __init__(self, parent=None):
        super().__init__(parent)
        self._has_session = False
        self._title = ""
        self._artist = ""
        self._playback_status = ""
        self._is_playing = False
        self._artwork = ""
        self._has_artwork = False
        self._is_busy = False

        self._stateReceived.connect(self._on_state_received, type=2)  # Qt.QueuedConnection
        self._executor = ThreadPoolExecutor(max_workers=1)

        self._timer = QTimer(self)
        self._timer.setInterval(1500)
        self._timer.timeout.connect(self.request_update)
        self._timer.start()

        self._is_busy = False
        self.request_update()

    @Slot()
    def request_update(self):
        if self._is_busy:
            return
        self._is_busy = True
        self._executor.submit(self._fetch_media_state)

    def _fetch_media_state(self):
        try:
            if not HAS_WINRT:
                self._stateReceived.emit({"has_session": False})
                return

            mgr_op = wmc.GlobalSystemMediaTransportControlsSessionManager.request_async()
            mgr = mgr_op.get()
            cur = mgr.get_current_session()
            if not cur:
                self._stateReceived.emit({"has_session": False})
                return

            props_op = cur.try_get_media_properties_async()
            props = props_op.get()
            title = props.title if props else ""
            artist = props.artist if props else ""

            info = cur.get_playback_info()
            status_code = info.playback_status if info else None

            if status_code == wmc.GlobalSystemMediaTransportControlsSessionPlaybackStatus.PLAYING:
                status_str = "playing"
                is_playing = True
            elif status_code == wmc.GlobalSystemMediaTransportControlsSessionPlaybackStatus.PAUSED:
                status_str = "paused"
                is_playing = False
            elif status_code == wmc.GlobalSystemMediaTransportControlsSessionPlaybackStatus.STOPPED:
                status_str = "stopped"
                is_playing = False
            else:
                status_str = "unknown"
                is_playing = False

            artwork_data = ""
            if props and props.thumbnail:
                try:
                    stream = props.thumbnail.open_read_async().get()
                    size = stream.size
                    if size > 0:
                        reader = streams.DataReader(stream)
                        reader.load_async(size).get()
                        buf = bytearray(size)
                        reader.read_bytes(buf)
                        artwork_data = "data:image/png;base64," + base64.b64encode(buf).decode("ascii")
                except Exception:
                    artwork_data = ""

            self._stateReceived.emit({
                "has_session": True,
                "title": title,
                "artist": artist,
                "status": status_str,
                "is_playing": is_playing,
                "artwork": artwork_data,
                "has_artwork": bool(artwork_data)
            })
        except Exception:
            self._stateReceived.emit({"has_session": False})

    @Slot(dict)
    def _on_state_received(self, data: dict):
        self._is_busy = False
        has_session = data.get("has_session", False)
        title = data.get("title", "")
        artist = data.get("artist", "")
        status = data.get("status", "")
        is_playing = data.get("is_playing", False)
        artwork = data.get("artwork", "")
        has_artwork = data.get("has_artwork", False)

        changed = (
            self._has_session != has_session
            or self._title != title
            or self._artist != artist
            or self._playback_status != status
            or self._is_playing != is_playing
            or self._artwork != artwork
            or self._has_artwork != has_artwork
        )

        self._has_session = has_session
        self._title = title
        self._artist = artist
        self._playback_status = status
        self._is_playing = is_playing
        self._artwork = artwork
        self._has_artwork = has_artwork

        if changed:
            self.mediaChanged.emit()

    def play_pause(self):
        self._executor.submit(self._do_play_pause)

    def next_track(self):
        self._executor.submit(self._do_next)

    def previous_track(self):
        self._executor.submit(self._do_previous)

    def _do_play_pause(self):
        try:
            if not HAS_WINRT:
                return
            mgr = wmc.GlobalSystemMediaTransportControlsSessionManager.request_async().get()
            cur = mgr.get_current_session()
            if cur:
                cur.try_toggle_play_pause_async().get()
                self._fetch_media_state()
        except Exception:
            pass

    def _do_next(self):
        try:
            if not HAS_WINRT:
                return
            mgr = wmc.GlobalSystemMediaTransportControlsSessionManager.request_async().get()
            cur = mgr.get_current_session()
            if cur:
                cur.try_skip_next_async().get()
                self._fetch_media_state()
        except Exception:
            pass

    def _do_previous(self):
        try:
            if not HAS_WINRT:
                return
            mgr = wmc.GlobalSystemMediaTransportControlsSessionManager.request_async().get()
            cur = mgr.get_current_session()
            if cur:
                cur.try_skip_previous_async().get()
                self._fetch_media_state()
        except Exception:
            pass

    @Property(bool, notify=mediaChanged)
    def hasSession(self) -> bool:
        return self._has_session

    @Property(str, notify=mediaChanged)
    def title(self) -> str:
        return self._title

    @Property(str, notify=mediaChanged)
    def artist(self) -> str:
        return self._artist

    @Property(str, notify=mediaChanged)
    def playbackStatus(self) -> str:
        return self._playback_status

    @Property(bool, notify=mediaChanged)
    def isPlaying(self) -> bool:
        return self._is_playing

    @Property(str, notify=mediaChanged)
    def artwork(self) -> str:
        return self._artwork

    @Property(bool, notify=mediaChanged)
    def hasArtwork(self) -> bool:
        return self._has_artwork

