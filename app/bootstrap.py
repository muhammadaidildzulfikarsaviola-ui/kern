import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl


def run() -> int:
    app = QGuiApplication(sys.argv)

    engine = QQmlApplicationEngine()

    qml_file = Path(__file__).parent / "ui" / "Main.qml"

    engine.load(QUrl.fromLocalFile(str(qml_file)))

    if not engine.rootObjects():
        return 1

    return app.exec()