import QtQuick

Item {
    id: homePage

    property var systemService: null
    property var mediaController: null

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: "#171717"
        border.color: "#2B2B2B"
        border.width: 1
        clip: true

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Column {
                spacing: 3

                Text {
                    text: "Welcome to KERN"
                    color: "#FFFFFF"
                    font.pixelSize: 18
                    font.bold: true
                }

                Text {
                    text: "Your desktop control center."
                    color: "#888888"
                    font.pixelSize: 11
                }
            }

            Row {
                width: parent.width
                spacing: 12

                Rectangle {
                    width: (parent.width - 12) / 2
                    height: 92
                    radius: 12
                    color: "#222222"
                    border.color: "#303030"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8

                        Text {
                            text: "CPU"
                            color: "#888888"
                            font.pixelSize: 10
                            font.letterSpacing: 0.6
                        }

                        Text {
                            text: Math.round(homePage.systemService ? homePage.systemService.cpuPercent : 0) + "%"
                            color: "#FFFFFF"
                            font.pixelSize: 22
                            font.bold: true
                        }

                        Rectangle {
                            width: parent.width
                            height: 5
                            radius: 3
                            color: "#353535"

                            Rectangle {
                                width: parent.width * Math.max(0, Math.min(100, homePage.systemService ? homePage.systemService.cpuPercent : 0)) / 100
                                height: parent.height
                                radius: 3
                                color: "#F59E0B"

                                Behavior on width {
                                    NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: (parent.width - 12) / 2
                    height: 92
                    radius: 12
                    color: "#222222"
                    border.color: "#303030"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 8

                        Text {
                            text: "RAM"
                            color: "#888888"
                            font.pixelSize: 10
                            font.letterSpacing: 0.6
                        }

                        Text {
                            text: Math.round(homePage.systemService ? homePage.systemService.memoryPercent : 0) + "%"
                            color: "#FFFFFF"
                            font.pixelSize: 22
                            font.bold: true
                        }

                        Text {
                            text: "Memory usage"
                            color: "#777777"
                            font.pixelSize: 9
                        }
                    }
                }
            }

            Rectangle {
                width: parent.width
                height: Math.max(78, parent.height - 92 - 12 - 12 - 38)
                radius: 12
                color: "#222222"
                border.color: "#303030"
                clip: true

                Row {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 12

                    Rectangle {
                        width: 54
                        height: 54
                        radius: 8
                        color: "#303030"
                        clip: true

                        Image {
                            anchors.fill: parent
                            source: homePage.mediaController && homePage.mediaController.hasArtwork ? homePage.mediaController.artwork : ""
                            fillMode: Image.PreserveAspectCrop
                            visible: homePage.mediaController && homePage.mediaController.hasArtwork
                        }

                        Text {
                            anchors.centerIn: parent
                            text: "♫"
                            color: "#888888"
                            font.pixelSize: 24
                            visible: !(homePage.mediaController && homePage.mediaController.hasArtwork)
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width - 66
                        spacing: 4

                        Text {
                            text: homePage.mediaController && homePage.mediaController.title !== "" ? homePage.mediaController.title : "Nothing playing"
                            color: "#FFFFFF"
                            font.pixelSize: 12
                            font.bold: true
                            elide: Text.ElideRight
                            width: parent.width
                        }

                        Text {
                            text: homePage.mediaController && homePage.mediaController.artist !== "" ? homePage.mediaController.artist : "Start playing music to see it here"
                            color: "#888888"
                            font.pixelSize: 10
                            elide: Text.ElideRight
                            width: parent.width
                        }

                        Text {
                            text: homePage.mediaController ? homePage.mediaController.playbackStatus.toUpperCase() : "MEDIA"
                            color: "#F59E0B"
                            font.pixelSize: 8
                            font.letterSpacing: 0.8
                        }
                    }
                }
            }
        }
    }
}
