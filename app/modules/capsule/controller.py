from PySide6.QtCore import QObject, Signal, Property, Slot
from app.services.system_service import SystemService


class CapsuleController(QObject):
    expandedChanged = Signal(bool)

    def __init__(self, system_service: SystemService, parent=None):
        super().__init__(parent)
        self._system_service = system_service
        self._expanded = False

    @Property(QObject, constant=True)
    def systemService(self) -> SystemService:
        return self._system_service

    @Property(bool, notify=expandedChanged)
    def expanded(self) -> bool:
        return self._expanded

    @expanded.setter
    def expanded(self, value: bool):
        if self._expanded != value:
            self._expanded = value
            self.expandedChanged.emit(self._expanded)

    @Slot()
    def toggleExpanded(self):
        self.expanded = not self._expanded

    @Slot()
    def collapse(self):
        self.expanded = False

