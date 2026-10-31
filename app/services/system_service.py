from PySide6.QtCore import QObject, Signal, Property, Slot, QTimer
import psutil


class SystemService(QObject):
    metricsChanged = Signal()

    def __init__(self, parent=None):
        super().__init__(parent)
        self._cpu_percent = 0.0
        self._memory_percent = 0.0
        self._status_text = "All systems operational"
        self._is_healthy = True

        try:
            psutil.cpu_percent(interval=None)
        except Exception:
            pass

        self._timer = QTimer(self)
        self._timer.setInterval(2000)
        self._timer.timeout.connect(self.update_metrics)
        self._timer.start()

        self.update_metrics()

    @Slot()
    def update_metrics(self):
        try:
            self._cpu_percent = psutil.cpu_percent(interval=None)
            mem = psutil.virtual_memory()
            self._memory_percent = mem.percent

            if self._cpu_percent > 90 or self._memory_percent > 95:
                self._status_text = f"High load: CPU {self._cpu_percent:.0f}% • RAM {self._memory_percent:.0f}%"
                self._is_healthy = False
            else:
                self._status_text = f"CPU {self._cpu_percent:.0f}%  •  RAM {self._memory_percent:.0f}%"
                self._is_healthy = True

            self.metricsChanged.emit()
        except Exception:
            pass

    @Property(float, notify=metricsChanged)
    def cpuPercent(self) -> float:
        return self._cpu_percent

    @Property(float, notify=metricsChanged)
    def memoryPercent(self) -> float:
        return self._memory_percent

    @Property(str, notify=metricsChanged)
    def statusText(self) -> str:
        return self._status_text

    @Property(bool, notify=metricsChanged)
    def isHealthy(self) -> bool:
        return self._is_healthy

