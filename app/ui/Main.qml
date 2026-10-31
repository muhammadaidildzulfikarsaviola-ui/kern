import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import "components"

Window {
    id: mainWindow

    visible: true
    width: capsule.expanded ? 620 : 190
    height: capsule.expanded ? 270 : 40
    flags: Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.Tool
    color: "transparent"

    property string activeTool: "home"

    onWidthChanged: x = Math.round((Screen.width - width) / 2)

    Behavior on width {
        NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }
    Behavior on height {
        NumberAnimation { duration: 260; easing.type: Easing.OutCubic }
    }

    Component.onCompleted: {
        x = Math.round((Screen.width - width) / 2)
        y = 0
    }

    Shortcut {
        sequence: "Escape"
        context: Qt.WindowShortcut
        onActivated: {
            if (mainWindow.activeTool !== "home")
                mainWindow.activeTool = "home"
            else
                capsule.expanded = false
        }
    }

    Shortcut {
        sequence: "Ctrl+Q"
        context: Qt.WindowShortcut
        onActivated: Qt.quit()
    }

    Capsule {
        id: capsule
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        expanded: false
        targetWindow: mainWindow
    }

    Rectangle {
        id: expandedPanel
        anchors.fill: parent
        radius: 28
        color: "#050505"
        visible: capsule.expanded
        opacity: capsule.expanded ? 1 : 0
        clip: true

        RowLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 14

            // Launcher grid on the left.
            GridLayout {
                id: launcher
                Layout.preferredWidth: 174
                Layout.fillHeight: true
                columns: 3
                rows: 2
                columnSpacing: 8
                rowSpacing: 8

                Repeater {
                    model: [
                        { key: "pomodoro", glyph: "◷", label: "Focus" },
                        { key: "clipboard", glyph: "▤", label: "Clip" },
                        { key: "controls", glyph: "⌘", label: "Control" },
                        { key: "audio", glyph: "♫", label: "Audio" },
                        { key: "system", glyph: "▥", label: "System" },
                        { key: "settings", glyph: "⚙", label: "Settings" }
                    ]

                    delegate: Item {
                        required property var modelData
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: 0
                        Layout.minimumHeight: 0

                        Rectangle {
                            anchors.fill: parent
                            radius: 13
                            color: mainWindow.activeTool === modelData.key ? "#3A2817" : "#1C1C1C"
                            border.width: mainWindow.activeTool === modelData.key ? 1 : 0
                            border.color: "#F59E0B"

                            Column {
                                anchors.centerIn: parent
                                spacing: 4

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: modelData.glyph
                                    color: mainWindow.activeTool === modelData.key ? "#F59E0B" : "#F2F2F2"
                                    font.pixelSize: 23
                                }

                                Text {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    text: modelData.label
                                    color: "#AFAFAF"
                                    font.pixelSize: 8
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: mainWindow.activeTool = modelData.key
                            }
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillHeight: true
                Layout.preferredWidth: 1
                color: "#292929"
            }

            // Right side: persistent RAM and media widgets, or selected tool.
            Item {
                id: contentArea
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 9
                    visible: mainWindow.activeTool === "home"

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 66
                        radius: 13
                        color: "#191919"

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 14
                            anchors.rightMargin: 14
                            spacing: 8

                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2
                                Text {
                                    text: "RAM"
                                    color: "#929292"
                                    font.pixelSize: 10
                                    font.letterSpacing: 1
                                }
                                Text {
                                    text: Math.round(systemService ? systemService.memoryPercent : 0) + "%"
                                    color: "#FFFFFF"
                                    font.pixelSize: 27
                                    font.bold: true
                                }
                            }

                            Text {
                                text: "MEMORY"
                                color: "#666666"
                                font.pixelSize: 9
                                font.letterSpacing: 1
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        radius: 13
                        color: "#191919"
                        clip: true

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 11
                            spacing: 11

                            Rectangle {
                                Layout.preferredWidth: 62
                                Layout.preferredHeight: 62
                                radius: 10
                                color: "#303030"
                                clip: true

                                Image {
                                    anchors.fill: parent
                                    source: mediaController && mediaController.hasArtwork ? mediaController.artwork : ""
                                    fillMode: Image.PreserveAspectCrop
                                    visible: mediaController && mediaController.hasArtwork
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: "♫"
                                    color: "#BBBBBB"
                                    font.pixelSize: 29
                                    visible: !(mediaController && mediaController.hasArtwork)
                                }
                            }

                            ColumnLayout {
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                spacing: 3

                                Text {
                                    text: "NOW PLAYING"
                                    color: "#F59E0B"
                                    font.pixelSize: 8
                                    font.letterSpacing: 1
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: mediaController && mediaController.title !== "" ? mediaController.title : "Nothing playing"
                                    color: "#FFFFFF"
                                    font.pixelSize: 12
                                    font.bold: true
                                    elide: Text.ElideRight
                                }

                                Text {
                                    Layout.fillWidth: true
                                    text: mediaController && mediaController.artist !== "" ? mediaController.artist : "Start playing music"
                                    color: "#929292"
                                    font.pixelSize: 10
                                    elide: Text.ElideRight
                                }

                                Item { Layout.fillHeight: true }

                                RowLayout {
                                    Layout.alignment: Qt.AlignRight
                                    spacing: 15

                                    Text {
                                        text: "◀◀"
                                        color: "#FFFFFF"
                                        font.pixelSize: 13
                                        MouseArea {
                                            anchors.fill: parent
                                            anchors.margins: -6
                                            enabled: !!mediaController
                                            onClicked: mediaController.previous()
                                        }
                                    }

                                    Text {
                                        text: mediaController && mediaController.isPlaying ? "Ⅱ" : "▶"
                                        color: "#FFFFFF"
                                        font.pixelSize: 17
                                        MouseArea {
                                            anchors.fill: parent
                                            anchors.margins: -6
                                            enabled: !!mediaController
                                            onClicked: mediaController.playPause()
                                        }
                                    }

                                    Text {
                                        text: "▶▶"
                                        color: "#FFFFFF"
                                        font.pixelSize: 13
                                        MouseArea {
                                            anchors.fill: parent
                                            anchors.margins: -6
                                            enabled: !!mediaController
                                            onClicked: mediaController.next()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                Loader {
                    anchors.fill: parent
                    active: mainWindow.activeTool !== "home"
                    visible: active
                    sourceComponent: {
                        switch (mainWindow.activeTool) {
                        case "pomodoro": return pomodoroComponent
                        case "clipboard": return placeholderComponent
                        case "controls": return placeholderComponent
                        case "audio": return placeholderComponent
                        case "system": return systemComponent
                        case "settings": return placeholderComponent
                        default: return placeholderComponent
                        }
                    }
                }
            }
        }
    }

    Component {
        id: pomodoroComponent
        PomodoroPage {
            anchors.fill: parent
        }
    }

    Component {
        id: systemComponent
        SystemPage {
            anchors.fill: parent
            systemService: systemService
        }
    }

    Component {
        id: placeholderComponent
        Rectangle {
            radius: 14
            color: "#191919"
            Column {
                anchors.centerIn: parent
                spacing: 7
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: mainWindow.activeTool === "clipboard" ? "CLIPBOARD" :
                          mainWindow.activeTool === "controls" ? "QUICK CONTROLS" :
                          mainWindow.activeTool === "audio" ? "AUDIO TOOLS" : "SETTINGS"
                    color: "#F59E0B"
                    font.pixelSize: 11
                    font.bold: true
                    font.letterSpacing: 1
                }
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "This module is not implemented yet."
                    color: "#888888"
                    font.pixelSize: 10
                }
            }
        }
    }
}
