import QtQuick
import QtQuick.Layouts

Item {
    id: mediaPage
    property var mediaController: null

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 34
        anchors.rightMargin: 34
        anchors.topMargin: 2
        anchors.bottomMargin: 17
        spacing: 16

        Rectangle {
            Layout.preferredWidth: 78
            Layout.preferredHeight: 78
            radius: 13
            color: "#F1F1F1"
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
                color: "#333333"
                font.pixelSize: 34
                visible: !(mediaPage.mediaController && mediaPage.mediaController.hasArtwork)
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 3

            Text {
                Layout.fillWidth: true
                text: mediaPage.mediaController && mediaPage.mediaController.title !== "" ? mediaPage.mediaController.title : "Nothing playing"
                color: "#FFFFFF"
                font.pixelSize: 16
                font.bold: true
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: mediaPage.mediaController && mediaPage.mediaController.artist !== "" ? mediaPage.mediaController.artist : "Start playing music"
                color: "#999999"
                font.pixelSize: 11
                elide: Text.ElideRight
            }

            Item { Layout.fillHeight: true }

            RowLayout {
                Layout.fillWidth: true
                spacing: 22

                Text {
                    text: "◌"
                    color: "#CCCCCC"
                    font.pixelSize: 22
                }

                Item { Layout.fillWidth: true }

                Text {
                    text: "◀◀"
                    color: "#FFFFFF"
                    font.pixelSize: 19
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        enabled: !!mediaPage.mediaController
                        onClicked: mediaPage.mediaController.previous()
                    }
                }

                Text {
                    text: mediaPage.mediaController && mediaPage.mediaController.isPlaying ? "Ⅱ" : "▶"
                    color: "#FFFFFF"
                    font.pixelSize: 24
                    font.bold: true
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        enabled: !!mediaPage.mediaController
                        onClicked: mediaPage.mediaController.playPause()
                    }
                }

                Text {
                    text: "▶▶"
                    color: "#FFFFFF"
                    font.pixelSize: 19
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        enabled: !!mediaPage.mediaController
                        onClicked: mediaPage.mediaController.next()
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }
    }
}
