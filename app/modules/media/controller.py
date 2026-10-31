from PySide6.QtCore import QObject, Signal, Property, Slot
from app.services.media_service import MediaService


class MediaController(QObject):
    mediaChanged = Signal()

    def __init__(self, media_service: MediaService, parent=None):
        super().__init__(parent)
        self._media_service = media_service
        self._media_service.mediaChanged.connect(self.mediaChanged)

    @Property(QObject, constant=True)
    def mediaService(self) -> MediaService:
        return self._media_service

    @Property(bool, notify=mediaChanged)
    def hasSession(self) -> bool:
        return self._media_service.hasSession

    @Property(str, notify=mediaChanged)
    def title(self) -> str:
        return self._media_service.title

    @Property(str, notify=mediaChanged)
    def artist(self) -> str:
        return self._media_service.artist

    @Property(str, notify=mediaChanged)
    def playbackStatus(self) -> str:
        return self._media_service.playbackStatus

    @Property(bool, notify=mediaChanged)
    def isPlaying(self) -> bool:
        return self._media_service.isPlaying

    @Property(str, notify=mediaChanged)
    def artwork(self) -> str:
        return self._media_service.artwork

    @Property(bool, notify=mediaChanged)
    def hasArtwork(self) -> bool:
        return self._media_service.hasArtwork

    @Slot()
    def playPause(self):
        self._media_service.play_pause()

    @Slot()
    def next(self):
        self._media_service.next_track()

    @Slot()
    def previous(self):
        self._media_service.previous_track()

