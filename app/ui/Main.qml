
import QtQuick
import QtQuick.Window
import "components"

Window {
    id: mainWindow

    visible: true

    width: 440
    height: 230

    flags: Qt.FramelessWindowHint
           | Qt.WindowStaysOnTopHint
           | Qt.Tool

    color: "transparent"

    x: (Screen.width - width) / 2
    y: 20

    Capsule {
        id: capsule

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        targetWindow: mainWindow
    }

    Shortcut {
        sequence: "Escape"
        context: Qt.WindowShortcut

        onActivated: {
            capsule.expanded = false
        }
    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.WindowShortcut

        onActivated: {
            Qt.quit()
        }
    }
}
