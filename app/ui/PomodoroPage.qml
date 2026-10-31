import QtQuick
import QtQuick.Layouts

Item {
    id: pomodoroPage

    property int focusDuration: 25 * 60
    property int shortBreakDuration: 5 * 60
    property int remainingSeconds: focusDuration
    property bool running: false
    property bool isBreak: false

    function formatTime(totalSeconds) {
        var minutes = Math.floor(totalSeconds / 60)
        var seconds = totalSeconds % 60
        return (minutes < 10 ? "0" : "") + minutes + ":" +
               (seconds < 10 ? "0" : "") + seconds
    }

    function resetTimer() {
        running = false
        remainingSeconds = isBreak ? shortBreakDuration : focusDuration
    }

    Timer {
        interval: 1000
        repeat: true
        running: pomodoroPage.running
        onTriggered: {
            if (pomodoroPage.remainingSeconds > 0) {
                pomodoroPage.remainingSeconds--
            } else {
                pomodoroPage.running = false
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 48
        anchors.rightMargin: 48
        anchors.topMargin: 1
        anchors.bottomMargin: 17
        spacing: 20

        Item {
            Layout.preferredWidth: 112
            Layout.fillHeight: true

            Rectangle {
                width: 88
                height: 88
                radius: 44
                anchors.centerIn: parent
                color: "transparent"
                border.width: 7
                border.color: pomodoroPage.isBreak ? "#F59E0B" : "#FF4B55"

                Rectangle {
                    anchors.centerIn: parent
                    width: 68
                    height: 68
                    radius: 34
                    color: "#101010"
                    border.width: 2
                    border.color: "#77232B"

                    Text {
                        anchors.centerIn: parent
                        text: "◴"
                        color: "#FFFFFF"
                        font.pixelSize: 47
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 2

            Text {
                text: "Pomodoro"
                color: "#FFFFFF"
                font.pixelSize: 16
                font.bold: true
            }

            Item { Layout.fillHeight: true }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: pomodoroPage.formatTime(pomodoroPage.remainingSeconds)
                color: "#FFFFFF"
                font.pixelSize: 38
                font.bold: true
            }

            Text {
                Layout.alignment: Qt.AlignHCenter
                text: pomodoroPage.isBreak ? "Short break" : "Focus time"
                color: "#999999"
                font.pixelSize: 12
            }

            Item { Layout.fillHeight: true }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 8

                Rectangle {
                    Layout.preferredWidth: 106
                    Layout.preferredHeight: 34
                    radius: 17
                    color: "#252525"
                    Text {
                        anchors.centerIn: parent
                        text: "☕ Short Break"
                        color: "#FFFFFF"
                        font.pixelSize: 10
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pomodoroPage.isBreak = true
                            pomodoroPage.resetTimer()
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 62
                    Layout.preferredHeight: 36
                    radius: 18
                    color: "#FF4B55"
                    Text {
                        anchors.centerIn: parent
                        text: pomodoroPage.running ? "Ⅱ" : "▶"
                        color: "#FFFFFF"
                        font.pixelSize: 16
                        font.bold: true
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (pomodoroPage.remainingSeconds <= 0)
                                pomodoroPage.resetTimer()
                            pomodoroPage.running = !pomodoroPage.running
                        }
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 106
                    Layout.preferredHeight: 34
                    radius: 17
                    color: "#252525"
                    Text {
                        anchors.centerIn: parent
                        text: "◉ Focus Time"
                        color: "#FFFFFF"
                        font.pixelSize: 10
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            pomodoroPage.isBreak = false
                            pomodoroPage.resetTimer()
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: 30
            Layout.preferredHeight: 30
            radius: 15
            color: "#252525"
            Text {
                anchors.centerIn: parent
                text: "↻"
                color: "#FFFFFF"
                font.pixelSize: 18
            }
            MouseArea {
                anchors.fill: parent
                onClicked: pomodoroPage.resetTimer()
            }
        }
    }
}
