import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import "components"

Window {
    id: mainWindow

    visible: true
    width: 560
    height: capsule.expanded ? 176 : 40
    minimumWidth: 560
    maximumWidth: 560
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool
    color: "transparent"

    property int currentPage: 0

    Behavior on height {
        NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    Component.onCompleted: {
        x = Math.round((Screen.width - width) / 2)
        y = 0
    }

    Shortcut {
        sequence: "Escape"
        context: Qt.WindowShortcut
        onActivated: capsule.expanded = false
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
        id: expandedPanel
        anchors.fill: parent
        radius: 30
        color: "#050505"
        visible: capsule.expanded
        opacity: capsule.expanded ? 1 : 0
        clip: true

        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: 18
            anchors.rightMargin: 18
            anchors.topMargin: 9
            anchors.bottomMargin: 8
            spacing: 3

            RowLayout {
                Layout.fillWidth: true
                Layout.preferredHeight: 24
                spacing: 8

                Rectangle {
                    width: 22
                    height: 22
                    radius: 11
                    color: "#00E676"

                    Text {
                        anchors.centerIn: parent
                        text: "ϟ"
                        color: "#07130B"
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                Text {
                    text: Qt.formatDateTime(new Date(), "ddd dd MMM yyyy")
                    color: "#E6E6E6"
                    font.pixelSize: 13
                }

                Text {
                    id: expandedClock
                    text: Qt.formatDateTime(new Date(), "hh:mm")
                    color: "#FFFFFF"
                    font.pixelSize: 13
                    font.bold: true
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "▮▮▮"
                    color: "#FFFFFF"
                    font.pixelSize: 12
                    font.bold: true
                }
            }

            SwipeView {
                id: pages
                Layout.fillWidth: true
                Layout.fillHeight: true
                currentIndex: mainWindow.currentPage
                interactive: true
                clip: true

                onCurrentIndexChanged: mainWindow.currentPage = currentIndex

                MediaPage {
                    mediaController: mediaController
                }

                PomodoroPage {}

                HomePage {
                    systemService: systemService
                    mediaController: mediaController
                }

                SystemPage {
                    systemService: systemService
                }

                ToolsPage {}
            }
        }

        Timer {
            interval: 1000
            running: capsule.expanded
            repeat: true
            onTriggered: expandedClock.text = Qt.formatDateTime(new Date(), "hh:mm")
        }

        Row {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 16
            anchors.rightMargin: 16
            spacing: 0

            Rectangle {
                width: 22
                height: 22
                radius: 11
                color: "#454545"
                opacity: mainWindow.currentPage === 0 ? 0.75 : 1
                Text { anchors.centerIn: parent; text: "‹"; color: "white"; font.pixelSize: 22 }
                MouseArea {
                    anchors.fill: parent
                    onClicked: pages.decrementCurrentIndex()
                    cursorShape: Qt.PointingHandCursor
                }
            }

            Item { width: 1; height: 1 }
        }

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 16
            width: 22
            height: 22
            radius: 11
            color: "#454545"
            Text { anchors.centerIn: parent; text: "‹"; color: "white"; font.pixelSize: 22 }
            MouseArea {
                anchors.fill: parent
                onClicked: pages.decrementCurrentIndex()
                cursorShape: Qt.PointingHandCursor
            }
        }

        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 16
            width: 22
            height: 22
            radius: 11
            color: "#454545"
            Text { anchors.centerIn: parent; text: "›"; color: "white"; font.pixelSize: 22 }
            MouseArea {
                anchors.fill: parent
                onClicked: pages.incrementCurrentIndex()
                cursorShape: Qt.PointingHandCursor
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            spacing: 6

            Repeater {
                model: 5
                delegate: Rectangle {
                    required property int index
                    width: mainWindow.currentPage === index ? 18 : 5
                    height: 4
                    radius: 2
                    color: mainWindow.currentPage === index ? "#FFFFFF" : "#666666"
                    Behavior on width { NumberAnimation { duration: 140 } }
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -5
                        onClicked: mainWindow.currentPage = index
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            z: -1
            onWheel: function(wheel) {
                if (wheel.angleDelta.y < 0)
                    pages.incrementCurrentIndex()
                else if (wheel.angleDelta.y > 0)
                    pages.decrementCurrentIndex()
            }
        }
    }
}
