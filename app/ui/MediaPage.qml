import QtQuick

Item {
    id: mediaPage
    property var mediaController: null
    signal backRequested()

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: "#171717"
        border.color: "#2B2B2B"

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Row {
                width: parent.width
                height: 28

                Text {
                    text: "NOW PLAYING"
                    color: "#F59E0B"
                    font.pixelSize: 10
                    font.bold: true
                    font.letterSpacing: 1
                    anchors.verticalCenter: parent.verticalCenter
                }

                Item { width: 1; height: 1 }

                Text {
                    text: "BACK  ‹"
                    color: "#BBBBBB"
                    font.pixelSize: 10
                    anchors.verticalCenter: parent.verticalCenter

                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        onClicked: mediaPage.backRequested()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Row {
                width: parent.width
                spacing: 14

                Rectangle {
                    width: 112
                    height: 112
                    radius: 12
                    color: "#2A2A2A"
                    clip: true

                    Image {
                        anchors.fill: parent
                        source: mediaPage.mediaController && mediaPage.mediaController.hasArtwork ? mediaPage.mediaController.artwork : ""
                        fillMode: Image.PreserveAspectCrop
                        visible: mediaPage.mediaController && mediaPage.mediaController.hasArtwork
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "♫"
                        color: "#777777"
                        font.pixelSize: 36
                        visible: !(mediaPage.mediaController && mediaPage.mediaController.hasArtwork)
                    }
                }

                Column {
                    width: parent.width - 126
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 7

                    Text {
                        width: parent.width
                        text: mediaPage.mediaController && mediaPage.mediaController.title !== "" ? mediaPage.mediaController.title : "Nothing playing"
                        color: "#FFFFFF"
                        font.pixelSize: 15
                        font.bold: true
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        width: parent.width
                        text: mediaPage.mediaController && mediaPage.mediaController.artist !== "" ? mediaPage.mediaController.artist : "No active media session"
                        color: "#999999"
                        font.pixelSize: 11
                        wrapMode: Text.WordWrap
                    }

                    Text {
                        text: mediaPage.mediaController ? mediaPage.mediaController.playbackStatus.toUpperCase() : "UNAVAILABLE"
                        color: "#F59E0B"
                        font.pixelSize: 9
                        font.letterSpacing: 0.8
                    }
                }
            }

            Item { width: 1; height: 1 }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 18

                Repeater {
                    model: [
                        { label: "PREV", action: 0 },
                        { label: "PLAY", action: 1 },
                        { label: "NEXT", action: 2 }
                    ]

                    delegate: Rectangle {
                        required property var modelData
                        width: modelData.action === 1 ? 54 : 46
                        height: modelData.action === 1 ? 54 : 46
                        radius: width / 2
                        color: modelData.action === 1 ? "#F59E0B" : "#303030"
                        anchors.verticalCenter: parent.verticalCenter

                        Text {
                            anchors.centerIn: parent
                            text: modelData.label
                            color: modelData.action === 1 ? "#171717" : "#FFFFFF"
                            font.pixelSize: 9
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            enabled: !!mediaPage.mediaController
                            onClicked: {
                                if (!mediaPage.mediaController)
                                    return
                                if (modelData.action === 0)
                                    mediaPage.mediaController.previous()
                                else if (modelData.action === 1)
                                    mediaPage.mediaController.playPause()
                                else
                                    mediaPage.mediaController.next()
                            }
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
        }
    }
}
