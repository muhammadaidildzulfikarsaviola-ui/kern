import QtQuick
import QtQuick.Window
import QtQuick.Controls as QQC
import "components"

Window {
    id: mainWindow

    visible: true

    flags: Qt.FramelessWindowHint
           | Qt.WindowStaysOnTopHint
           | Qt.Tool

    color: "transparent"

    width: capsule.windowWidth
    height: capsule.windowHeight

    Behavior on width {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Behavior on height {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    Component.onCompleted: {
        mainWindow.x = Math.round((Screen.width - mainWindow.width) / 2)
        mainWindow.y = 20
    }

    Connections {
        target: capsule

        function onExpandedChanged() {
            var centerX = mainWindow.x + mainWindow.width / 2
            var newWidth = capsule.expanded ? capsule.expandedWidth : capsule.compactWidth
            mainWindow.x = Math.round(centerX - newWidth / 2)
        }
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

        onActivated: {
            Qt.quit()
        }
    }

    Capsule {
        id: capsule

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        targetWindow: mainWindow
    }

    // Navigation bar - compact view when collapsed
    Rectangle {
        id: navBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: capsule.expanded ? 0 : 44
        color: "#171717"
        radius: 12
        clip: true
        visible: !capsule.expanded

        Row {
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            spacing: 8

            Rectangle {
                id: homeBtn
                width: 36
                height: 36
                radius: 18
                color: currentPage === 0 ? "#F59E0B" : "#3F3F3F"

                Text {
                    anchors.centerIn: parent
                    text: "1"
                    color: currentPage === 0 ? "#171717" : "#FFFFFF"
                    font.pixelSize: 12
                    font.bold: currentPage === 0
                }
            }

            Rectangle {
                id: mediaBtn
                width: 36
                height: 36
                radius: 18
                color: currentPage === 1 ? "#F59E0B" : "#3F3F3F"
                

                Text {
                    anchors.centerIn: parent
                    text: "2"
                    color: currentPage === 1 ? "#171717" : "#FFFFFF"
                    font.pixelSize: 12
                    font.bold: currentPage === 1
                }
            }

            Rectangle {
                id: systemBtn
                width: 36
                height: 36
                radius: 18
                color: currentPage === 2 ? "#F59E0B" : "#3F3F3F"
                

                Text {
                    anchors.centerIn: parent
                    text: "3"
                    color: currentPage === 2 ? "#171717" : "#FFFFFF"
                    font.pixelSize: 12
                    font.bold: currentPage === 2
                }
            }

            Rectangle {
                id: toolsBtn
                width: 36
                height: 36
                radius: 18
                color: currentPage === 3 ? "#F59E0B" : "#3F3F3F"
                

                Text {
                    anchors.centerIn: parent
                    text: "4"
                    color: currentPage === 3 ? "#171717" : "#FFFFFF"
                    font.pixelSize: 12
                    font.bold: currentPage === 3
                }
            }
        }
    }

    // Main content area with page loader
    Loader {
        id: pageLoader
        anchors.fill: parent
        anchors.topMargin: capsule.compactHeight

        source: currentPage === 0 ? "HomePage.qml" :
                currentPage === 1 ? "MediaPage.qml" :
                currentPage === 2 ? "SystemPage.qml" : "ToolsPage.qml"
    }

    // Navigation function
    function navigateTo(pageId) {
        currentPage = pageId
    }

    property int currentPage: 0
    property int compactHeight: 56
    property int expandedHeight: (typeof mediaController !== "undefined" && mediaController && mediaController.hasSession) ? 312 : 220
}