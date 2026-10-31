import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl

from app.services.system_service import SystemService
from app.services.media_service import MediaService
from app.modules.capsule.controller import CapsuleController
from app.modules.media.controller import MediaController


def run() -> int:
    app = QGuiApplication(sys.argv)

    system_service = SystemService()
    media_service = MediaService()

    capsule_controller = CapsuleController(system_service)
    media_controller = MediaController(media_service)

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("systemService", system_service)
    engine.rootContext().setContextProperty("mediaService", media_service)
    engine.rootContext().setContextProperty("capsuleController", capsule_controller)
    engine.rootContext().setContextProperty("mediaController", media_controller)

    qml_file = Path(__file__).parent / "ui" / "Main.qml"

    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        return 1

    return app.exec()
