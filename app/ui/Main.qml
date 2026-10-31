import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "components"

Window {
    id: mainWindow

    visible: true
    width: 460
    height: capsule.expanded ? 410 : 104

    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool
    color: "transparent"

    property int currentPage: 0

    Behavior on height {
        NumberAnimation {
            duration: 280
            easing.type: Easing.OutCubic
        }
    }

    Component.onCompleted: {
        x = Math.round((Screen.width - width) / 2)
        y = 24
    }

    Shortcut {
        sequence: "Escape"
        context: Qt.WindowShortcut
        onActivated: {
            if (currentPage !== 0) {
                currentPage = 0
            } else {
                capsule.expanded = false
            }
        }
    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.WindowShortcut
        onActivated: Qt.quit()
    }

    Capsule {
        id: capsule
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        expanded: false
        targetWindow: mainWindow
    }

    Rectangle {
        id: navBar
        width: capsule.expanded ? 420 : 190
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 56
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 20
        color: "#202020"
        border.color: "#303030"
        border.width: 1
        clip: true

        Behavior on width {
            NumberAnimation {
                duration: 220
                easing.type: Easing.OutCubic
            }
        }

        Row {
            anchors.centerIn: parent
            spacing: 8

            Repeater {
                model: ["HOME", "MEDIA", "SYSTEM", "TOOLS"]

                delegate: Rectangle {
                    required property int index
                    required property string modelData

                    width: capsule.expanded ? 92 : 36
                    height: 32
                    radius: 16
                    color: mainWindow.currentPage === index ? "#F59E0B" : "#3A3A3A"

                    Behavior on width {
                        NumberAnimation { duration: 180 }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: capsule.expanded ? modelData : String(index + 1)
                        color: mainWindow.currentPage === index ? "#171717" : "#FFFFFF"
                        font.pixelSize: capsule.expanded ? 9 : 12
                        font.bold: mainWindow.currentPage === index
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: mainWindow.currentPage = index
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }

    Loader {
        id: pageLoader
        anchors.top: navBar.bottom
        anchors.topMargin: 12
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 12
        visible: capsule.expanded
        active: capsule.expanded

        source: {
            switch (mainWindow.currentPage) {
            case 1: return "MediaPage.qml"
            case 2: return "SystemPage.qml"
            case 3: return "ToolsPage.qml"
            default: return "HomePage.qml"
            }
        }

        onLoaded: {
            if (!item)
                return

            if (item.hasOwnProperty("systemService"))
                item.systemService = systemService

            if (item.hasOwnProperty("mediaController"))
                item.mediaController = mediaController

            if (item.hasOwnProperty("onBackPressed"))
                item.onBackPressed = function() { mainWindow.currentPage = 0 }
        }
    }
}
