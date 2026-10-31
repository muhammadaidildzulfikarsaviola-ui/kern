import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QByteArray

app = QGuiApplication(sys.argv)

# Test 1: Minimal QML
engine = QQmlApplicationEngine()
minimal = 'import QtQuick\nimport QtQuick.Window\nWindow { visible: true width: 200 height: 200 }'
engine.loadData(minimal.encode())
print('Test 1 - Minimal QML:')
print('  Root objects:', len(engine.rootObjects()))
print()

# Test 2: Main.qml
engine2 = QQmlApplicationEngine()
with open('app/ui/Main.qml', 'rb') as f:
    data = f.read()
engine2.loadData(data)
print('Test 2 - Main.qml:')
print('  Root objects:', len(engine2.rootObjects()))
if engine2.rootObjects():
    print('  Success!')
else:
    print('  Failed - no root objects')
    if hasattr(engine2, 'errorString'):
        print('  ErrorString:', engine2.errorString())