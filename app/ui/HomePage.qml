import QtQuick
import QtQuick.Window

Item {
    id: homePage

    property var systemService
    property var mediaController

    width: parent.width
    height: parent.height

    // Home content area - occupies the space below the capsule
    Rectangle {
        id: contentArea
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#171717"
        radius: 12
        clip: true

        Row {
            id: homeRow
            anchors.fill: contentArea
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            spacing: 14

            // Calculate card height based on available space
            // Use capsule height metrics for consistent sizing
            property int cardHeight: (capsule.expanded ? 200 : 120)
            property int cardWidth: (capsule.expanded ? 300 : 140)

            // System monitor card
            Rectangle {
                id: systemCard
                width: cardWidth
                height: cardHeight
                radius: 12
                color: "#222222"
                clip: true

                Column {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    spacing: 8

                    Text {
                        text: "CPU"
                        color: "#888888"
                        font.pixelSize: 9
                        font.letterSpacing: 0.5
                    }

                    Rectangle {
                        id: cpuTrack
                        height: 6
                        radius: 3
                        color: "#303030"
                        width: parent.width - 20

                        Rectangle {
                            height: parent.height - 24
                            radius: 3
                            color: (typeof systemService !== "undefined" && systemService && systemService.cpuPercent > 90) ? "#EF4444" : "#F59E0B"
                            width: Math.max(0, Math.min(100, (typeof systemService !== "undefined" && systemService) ? systemService.cpuPercent : 0)) / 100 * parent.width

                            Behavior on width {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    }

                    Text {
                        text: Math.round((typeof systemService !== "undefined" && systemService) ? systemService.cpuPercent : 0) + "%"
                        color: "#FFFFFF"
                        font.pixelSize: 11
                        font.bold: true
                        anchors AlignRight: true
                    }

                    Text {
                        text: "RAM"
                        color: "#888888"
                        font.pixelSize: 9
                        font.letterSpacing: 0.5
                        anchors topMargin: 6
                    }

                    Rectangle {
                        id: ramTrack
                        height: 6
                        radius: 3
                        color: "#303030"
                        width: parent.width - 20

                        Rectangle {
                            height: parent.height - 24
                            radius: 3
                            color: (typeof systemService !== "undefined" && systemService && systemService.memoryPercent > 90) ? "#EF4444" : "#F59E0B"
                            width: Math.max(0, Math.min(100, (typeof systemService !== "undefined" && systemService) ? systemService.memoryPercent : 0)) / 100 * parent.width

                            Behavior on width {
                                NumberAnimation {
                                    duration: 300
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    }

                    Text {
                        text: Math.round((typeof systemService !== "undefined" && systemService) ? systemService.memoryPercent : 0) + "%"
                        color: "#FFFFFF"
                        font.pixelSize: 11
                        font.bold: true
                        anchors AlignRight: true
                    }
                }
            }

            // Media card
            Rectangle {
                id: mediaCard
                width: cardWidth
                height: cardHeight
                radius: 12
                color: "#222222"
                clip: true

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    Rectangle {
                        id: artworkContainer
                        width: 40
                        height: 40
                        radius: 8
                        color: "#2A2A2A"
                        clip: true

                        Image {
                            id: artworkImage
                            anchors.fill: parent
                            source: (typeof mediaController !== "undefined" && mediaController && mediaController.hasArtwork) ? mediaController.artwork : ""
                            fillMode: Image.PreserveAspectCrop
                            visible: mediaController.hasArtwork && mediaController.artwork !== ""
                        }

                        Text {
                            anchors.centerIn: artworkContainer
                            text: "\u266B"
                            color: "#666666"
                            font.pixelSize: 16
                            visible: !artworkImage.visible
                        }
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        spacing: 2

                        Text {
                            text: (typeof mediaController !== "undefined" && mediaController && mediaController.title !== "") ? mediaController.title : "Unknown Title"
                            color: "#FFFFFF"
                            font.pixelSize: 11
                            font.bold: true
                            elide: Text.ElideRight
                        }

                        Text {
                            text: (typeof mediaController !== "undefined" && mediaController && mediaController.artist !== "") ? mediaController.artist : "Unknown Artist"
                            color: "#888888"
                            font.pixelSize: 9
                            elide: Text.ElideRight
                        }
                    }

                    Row {
                        spacing: 3

                        Rectangle {
                            width: 4
                            height: 4
                            radius: 2
                            anchors.verticalCenter: parent.verticalCenter
                            color: (typeof mediaController !== "undefined" && mediaController && mediaController.isPlaying) ? "#10B981" : "#6B7280"
                        }

                        Text {
                            text: (typeof mediaController !== "undefined" && mediaController && mediaController.playbackStatus !== "") ? mediaController.playbackStatus.toUpperCase() : ""
                            color: "#666666"
                            font.pixelSize: 7
                            font.bold: true
                            font.letterSpacing: 0.8
                        }
                    }
                }
            }
        }
    }
}