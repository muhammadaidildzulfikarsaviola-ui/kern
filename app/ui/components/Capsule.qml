import QtQuick

Item {
    id: root

    property bool expanded: false
    property var targetWindow: null

    width: parent ? parent.width : 460
    height: 48

    Rectangle {
        id: capsuleBackground
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.expanded ? 420 : 180
        height: 48
        radius: 24
        color: "#171717"
        border.width: 1
        border.color: "#303030"

        Behavior on width {
            NumberAnimation {
                duration: 280
                easing.type: Easing.OutCubic
            }
        }

        Row {
            anchors.fill: parent
            anchors.leftMargin: 20
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
                width: Math.max(0, parent.width - 150)
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
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor

            property point pressGlobalPosition: Qt.point(0, 0)
            property point windowStartPosition: Qt.point(0, 0)
            property bool dragged: false

            onPressed: function(mouse) {
                pressGlobalPosition = mapToGlobal(mouse.x, mouse.y)
                if (root.targetWindow) {
                    windowStartPosition = Qt.point(root.targetWindow.x, root.targetWindow.y)
                }
                dragged = false
            }

            onPositionChanged: function(mouse) {
                if (!pressed || !root.targetWindow)
                    return

                var globalPosition = mapToGlobal(mouse.x, mouse.y)
                var deltaX = globalPosition.x - pressGlobalPosition.x
                var deltaY = globalPosition.y - pressGlobalPosition.y

                if (Math.abs(deltaX) > 4 || Math.abs(deltaY) > 4)
                    dragged = true

                if (dragged) {
                    root.targetWindow.x = windowStartPosition.x + deltaX
                    root.targetWindow.y = windowStartPosition.y + deltaY
                }
            }

            onClicked: {
                if (!dragged)
                    root.expanded = !root.expanded
            }
        }
    }
}
