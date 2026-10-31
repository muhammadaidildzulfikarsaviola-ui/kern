import QtQuick
import QtQuick.Window

Item {
    id: systemPage

    property var systemService
    onBackPressed: { /* signal to navigator */ }

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
            text: "System Status"
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

    // CPU and RAM metrics
    Row {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 12
        spacing: 20

        // CPU card
        Rectangle {
            id: cpuCard
            width: (parent.width - 40) / 2
            height: 100
            radius: 12
            color: "#222222"
            clip: true

            Column {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.topMargin: 12
                anchors.bottomMargin: 12
                spacing: 6

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
                    width: (parent.width - 40) / 2

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
            }
        }

        // RAM card
        Rectangle {
            id: ramCard
            width: (parent.width - 40) / 2
            height: 100
            radius: 12
            color: "#222222"
            clip: true

            Column {
                anchors.fill: parent
                anchors.leftMargin: 12
                anchors.rightMargin: 12
                anchors.topMargin: 12
                anchors.bottomMargin: 12
                spacing: 6

                Text {
                    text: "RAM"
                    color: "#888888"
                    font.pixelSize: 9
                    font.letterSpacing: 0.5
                }

                Rectangle {
                    id: ramTrack
                    height: 6
                    radius: 3
                    color: "#303030"
                    width: (parent.width - 40) / 2

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
    }

    // Device info
    Row {
        anchors.top: metricsRow.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 12

        Text {
            text: "Kernel " + Qt.application.version
            color: "#888888"
            font.pixelSize: 10
        }
    }

    // Navigation hint
    Row {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 32
        spacing: 8

        Text {
            text: "Swipe left/right to navigate | Escape to collapse"
            color: "#666666"
            font.pixelSize: 9
        }
    }

    // Placeholder for future modules (GPU, Disk, Network)
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 12
        clip: true

        Text {
            anchors.centerIn: parent
            text: "Module Placeholder - GPU / Disk / Network"
            color: "#555555"
            font.pixelSize: 10
        }
    }
}