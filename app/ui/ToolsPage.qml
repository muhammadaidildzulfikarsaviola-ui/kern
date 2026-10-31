import QtQuick

Item {
    id: toolsPage

    property var systemService
    property var mediaController

    width: parent.width
    height: parent.height
    color: "#171717"

    Text {
        anchors.centerIn: parent
        text: "Tools"
        color: "#888888"
        font.pixelSize: 14
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 44
        color: "#2A2A2A"
        radius: 12
        clip: true

        Text {
            anchors.centerIn: parent
            text: "Placeholder - Clipboard / Pomodoro"
            color: "#666666"
            font.pixelSize: 10
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}