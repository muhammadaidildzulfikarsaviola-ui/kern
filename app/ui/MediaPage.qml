import QtQuick
import QtQuick.Window

Item {
    id: mediaPage

    property var mediaController

    width: parent.width
    height: parent.height

    // Header bar
    Row {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 44
        spacing: 8

        Text {
            text: "Now Playing"
            color: "#FFFFFF"
            font.pixelSize: 14
            font.bold: true
        }

        Rectangle {
            width: 28
            height: 28
            radius: 14
            color: "#282828"

            MouseArea {
                anchors.fill: parent
                onClicked: { onBackPressed() }

                Text {
                    anchors.centerIn: parent
                    text: "\u23EC"
                    color: "#CCCCCC"
                    font.pixelSize: 12
                }
            }
        }
    }

    // Artwork and metadata
    Row {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 12
        spacing: 12

        // Artwork
        Rectangle {
            id: artworkContainer
            width: 64
            height: 64
            radius: 10
            color: "#2A2A2A"
            clip: true

            Image {
                id: artworkImage
                anchors.fill: parent
                source: mediaController.artwork
                fillMode: Image.PreserveAspectCrop
                visible: mediaController.hasArtwork && mediaController.artwork !== ""
            }

            Text {
                anchors.centerIn: artworkContainer
                text: "\u266B"
                color: "#666666"
                font.pixelSize: 22
                visible: !artworkImage.visible
            }
        }

        // Metadata column
        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 70
            spacing: 3

            Text {
                text: mediaController.title !== "" ? mediaController.title : "Unknown Title"
                color: "#FFFFFF"
                font.pixelSize: 12
                font.bold: true
                elide: Text.ElideRight
            }

            Text {
                text: mediaController.artist !== "" ? mediaController.artist : "Unknown Artist"
                color: "#888888"
                font.pixelSize: 10
                elide: Text.ElideRight
            }
        }
    }

    // Playback controls at bottom
    Rectangle {
        id: playbackControls
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 44
        color: "#171717"
        radius: 12
        clip: true

        Row {
            anchors.fill: parent
            anchors.leftMargin: 12
            anchors.rightMargin: 12
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            // Previous
            Rectangle {
                width: 28
                height: 28
                radius: 14
                color: "#282828"

                Text {
                    anchors.centerIn: parent
                    text: "\u23EE"
                    color: "#CCCCCC"
                    font.pixelSize: 12
                }
            }

            // Play/Pause
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: mediaController.isPlaying ? "#404040" : "#303030"

                Text {
                    anchors.centerIn: parent
                    text: mediaController.isPlaying ? "\u23F8" : "\u25B6"
                    color: "#FFFFFF"
                    font.pixelSize: 12
                }
            }

            // Next
            Rectangle {
                width: 28
                height: 28
                radius: 14
                color: "#282828"

                Text {
                    anchors.centerIn: parent
                    text: "\u23ED"
                    color: "#CCCCCC"
                    font.pixelSize: 12
                }
            }
        }
    }
}