import QtQuick

Item {
    id: toolsPage

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: "#171717"
        border.color: "#2B2B2B"

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "TOOLS"
                color: "#F59E0B"
                font.pixelSize: 11
                font.bold: true
                font.letterSpacing: 1
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Productivity modules are coming soon."
                color: "#888888"
                font.pixelSize: 11
            }
        }
    }
}
