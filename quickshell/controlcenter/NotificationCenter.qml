import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Notifications

Rectangle {
    implicitHeight: Math.min(column.implicitHeight + 20, 400)
    color: Qt.lighter(Theme.backgroundColor, 1.05)
    radius: 5
    border.width: 1
    border.color: Qt.lighter(Theme.backgroundColor, 1.15)

    NotificationServer {
        id: notifServer
    }

    ColumnLayout {
        id: column
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Header
        Text {
            text: "Notifications"
            color: Theme.foregroundColor
            font.pixelSize: 14
            font.family: Theme.textFont
            font.bold: true
        }

        // Notifications list
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true

            ColumnLayout {
                width: parent.width
                spacing: 8

                Repeater {
                    model: notifServer.trackedNotifications

                    // Individual notification item
                    Rectangle {
                        id: notificationItem
                        required property var modelData

                        Layout.fillWidth: true
                        implicitHeight: notifContent.implicitHeight + 16
                        color: Qt.darker(Theme.backgroundColor, 1.02)
                        radius: 5
                        border.width: 1
                        border.color: Qt.lighter(Theme.backgroundColor, 1.1)

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 8

                            ColumnLayout {
                                id: notifContent
                                Layout.fillWidth: true
                                spacing: 4

                                // App name and summary
                                Text {
                                    Layout.fillWidth: true
                                    text: notificationItem.modelData.appName + ": " + notificationItem.modelData.summary
                                    color: Theme.foregroundColor
                                    font.pixelSize: 12
                                    font.family: Theme.textFont
                                    font.bold: true
                                    elide: Text.ElideRight
                                    maximumLineCount: 1
                                }

                                // Body text
                                Text {
                                    Layout.fillWidth: true
                                    text: notificationItem.modelData.body
                                    color: Qt.lighter(Theme.foregroundColor, 1.2)
                                    font.pixelSize: 10
                                    font.family: Theme.textFont
                                    wrapMode: Text.WordWrap
                                    maximumLineCount: 3
                                    elide: Text.ElideRight
                                    visible: text.length > 0
                                }
                            }

                            // Dismiss button
                            Rectangle {
                                implicitWidth: 24
                                implicitHeight: 24
                                radius: 12
                                color: "transparent"
                                border.width: 1
                                border.color: Theme.foregroundColor

                                Text {
                                    anchors.centerIn: parent
                                    text: "×"
                                    color: Theme.foregroundColor
                                    font.pixelSize: 16
                                    font.bold: true
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: notificationItem.modelData.dismiss()
                                }
                            }
                        }
                    }
                }

                // Empty state
                Text {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    text: "No notifications"
                    color: Qt.lighter(Theme.foregroundColor, 1.5)
                    font.pixelSize: 12
                    font.family: Theme.textFont
                    horizontalAlignment: Text.AlignHCenter
                    visible: notifServer.trackedNotifications.length === 0
                }
            }
        }
    }

    // Automatically track new notifications
    Connections {
        target: notifServer
        function onNotification(notification) {
            notification.tracked = true
        }
    }
}
