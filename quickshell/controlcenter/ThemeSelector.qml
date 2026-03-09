import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    implicitHeight: column.implicitHeight + 20
    color: Qt.lighter(Theme.backgroundColor, 1.1)
    radius: 5
    border.width: 1
    border.color: Qt.lighter(Theme.backgroundColor, 1.3)

    ColumnLayout {
        id: column
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        Text {
            text: "Theme"
            color: Theme.foregroundColor
            font.pixelSize: 14
            font.family: Theme.textFont
            font.bold: true
        }

        Flow {
            Layout.fillWidth: true
            spacing: 8

            Repeater {
                model: Theme.themeNames

                Rectangle {
                    required property string modelData
                    property bool isSelected: Theme.currentTheme === modelData

                    width: 80
                    height: 30
                    radius: 5
                    color: isSelected ? Theme.highlightColor : Qt.rgba(0.3, 0.3, 0.3, 1.0)
                    border.width: 1
                    border.color: isSelected ? Theme.highlightColor : Qt.rgba(0.5, 0.5, 0.5, 1.0)

                    Text {
                        anchors.centerIn: parent
                        text: Theme.themes[parent.modelData].name
                        color: parent.isSelected ? "#ffffff" : Theme.foregroundColor
                        font.pixelSize: 10
                        font.family: Theme.textFont
                        elide: Text.ElideRight
                        width: parent.width - 10
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Theme.currentTheme = parent.modelData
                    }

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
            }
        }
    }
}
