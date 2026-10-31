
import QtQuick

Item {
    id: root

    property bool expanded: false

    property var targetWindow

    property point dragOffset: Qt.point(0, 0)

    width: 440
    height: 220

    Rectangle {
        id: capsuleBackground

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        width: root.expanded ? 420 : 180
        height: root.expanded ? 210 : 48

        radius: 24
        color: "#171717"

        border.width: 1
        border.color: "#303030"

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

        Row {
            id: header

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: 48
            anchors.leftMargin: 18
            anchors.rightMargin: 18

            spacing: 8

            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: "KERN"
                color: "#FFFFFF"

                font.pixelSize: 15
                font.bold: true
                font.letterSpacing: 1.5
            }

            Item {
                width: root.expanded ? 250 : 15
                height: 1
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter

                width: 7
                height: 7
                radius: 4

                color: "#F59E0B"
            }

            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: root.expanded ? "ACTIVE" : "READY"
                color: "#999999"

                font.pixelSize: 9
                font.letterSpacing: 1
            }
        }

        MouseArea {
            id: dragArea

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: 48

            acceptedButtons: Qt.LeftButton
            hoverEnabled: true

            property point pressGlobalPosition: Qt.point(0, 0)
            property bool dragged: false

            onPressed: function(mouse) {
                var globalPosition = mapToGlobal(mouse.x, mouse.y)

                root.dragOffset = Qt.point(
                    globalPosition.x - root.targetWindow.x,
                    globalPosition.y - root.targetWindow.y
                )

                pressGlobalPosition = globalPosition
                dragged = false
            }

            onPositionChanged: function(mouse) {
                if (!pressed)
                    return

                var globalPosition = mapToGlobal(mouse.x, mouse.y)

                var deltaX = globalPosition.x - pressGlobalPosition.x
                var deltaY = globalPosition.y - pressGlobalPosition.y

                if (Math.abs(deltaX) > 4 || Math.abs(deltaY) > 4)
                    dragged = true

                if (dragged) {
                    root.targetWindow.x =
                        globalPosition.x - root.dragOffset.x

                    root.targetWindow.y =
                        globalPosition.y - root.dragOffset.y
                }
            }

            onClicked: {
                if (!dragged)
                    root.expanded = !root.expanded
            }

            cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor
        }

        Column {
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 8

            spacing: 12

            opacity: root.expanded ? 1 : 0
            visible: root.expanded

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }

            Rectangle {
                width: parent.width
                height: 1
                color: "#303030"
            }

            Text {
                text: "Welcome to KERN"
                color: "#FFFFFF"

                font.pixelSize: 18
                font.bold: true
            }

            Text {
                text: "Your desktop control center."
                color: "#888888"

                font.pixelSize: 12
            }

            Rectangle {
                width: parent.width
                height: 70

                radius: 12
                color: "#222222"

                Column {
                    anchors.centerIn: parent
                    spacing: 5

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "SYSTEM STATUS"
                        color: "#888888"

                        font.pixelSize: 9
                        font.letterSpacing: 1
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: "All systems operational"
                        color: "#FFFFFF"

                        font.pixelSize: 13
                    }
                }
            }
        }
    }
}
