import QtQuick

Item {
    id: systemPage
    property var systemService: null
    signal backRequested()

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: "#171717"
        border.color: "#2B2B2B"

        Column {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 14

            Row {
                width: parent.width
                height: 28

                Text {
                    text: "SYSTEM OVERVIEW"
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
                        onClicked: systemPage.backRequested()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Row {
                width: parent.width
                spacing: 12

                Rectangle {
                    width: (parent.width - 12) / 2
                    height: 108
                    radius: 12
                    color: "#222222"
                    border.color: "#303030"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 9

                        Text {
                            text: "CPU"
                            color: "#888888"
                            font.pixelSize: 10
                        }

                        Text {
                            text: Math.round(systemPage.systemService ? systemPage.systemService.cpuPercent : 0) + "%"
                            color: "#FFFFFF"
                            font.pixelSize: 24
                            font.bold: true
                        }

                        Rectangle {
                            width: parent.width
                            height: 5
                            radius: 3
                            color: "#353535"

                            Rectangle {
                                width: parent.width * Math.max(0, Math.min(100, systemPage.systemService ? systemPage.systemService.cpuPercent : 0)) / 100
                                height: parent.height
                                radius: 3
                                color: "#F59E0B"
                            }
                        }
                    }
                }

                Rectangle {
                    width: (parent.width - 12) / 2
                    height: 108
                    radius: 12
                    color: "#222222"
                    border.color: "#303030"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 9

                        Text {
                            text: "RAM"
                            color: "#888888"
                            font.pixelSize: 10
                        }

                        Text {
                            text: Math.round(systemPage.systemService ? systemPage.systemService.memoryPercent : 0) + "%"
                            color: "#FFFFFF"
                            font.pixelSize: 24
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
                height: 66
                radius: 12
                color: "#222222"
                border.color: "#303030"

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
                        text: systemPage.systemService ? systemPage.systemService.statusText : "System metrics unavailable"
                        color: "#FFFFFF"
                        font.pixelSize: 11
                    }
                }
            }
        }
    }
}
