import QtQuick

Item {
    id: root

    property bool expanded: false
    property var targetWindow: null

    width: parent ? parent.width : 560
    height: 40

    Rectangle {
        id: pill
        visible: !root.expanded
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: 190
        height: 40
        radius: 20
        color: "#050505"

        Row {
            anchors.centerIn: parent
            spacing: 10

            Rectangle {
                width: 22
                height: 22
                radius: 11
                color: "#00E676"
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    anchors.centerIn: parent
                    text: "ϟ"
                    color: "#07130B"
                    font.pixelSize: 16
                    font.bold: true
                }
            }

            Text {
                id: clock
                anchors.verticalCenter: parent.verticalCenter
                text: Qt.formatDateTime(new Date(), "hh:mm")
                color: "#FFFFFF"
                font.pixelSize: 18
                font.bold: true
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "▮▮▮"
                color: "#FFFFFF"
                font.pixelSize: 12
                font.bold: true
            }
        }

        Timer {
            interval: 1000
            running: !root.expanded
            repeat: true
            onTriggered: clock.text = Qt.formatDateTime(new Date(), "hh:mm")
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: root.expanded = true
        }
    }
}
