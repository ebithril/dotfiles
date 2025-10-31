import QtQuick
import Quickshell

Rectangle {
    id: button

    property bool controlCenterShown: false
    signal clicked()

    implicitWidth: label.width + 20
    implicitHeight: 25
    color: "transparent"

    Text {
        id: label
        anchors.centerIn: parent
        text: controlCenterShown ? "" : ""
        color: "#B9EFF8"
        font.pixelSize: 14
        font.family: "FiraCode"

        Behavior on text {
            SequentialAnimation {
                NumberAnimation { target: label; property: "opacity"; to: 0; duration: 75 }
                PropertyAction { target: label; property: "text" }
                NumberAnimation { target: label; property: "opacity"; to: 1; duration: 75 }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: button.clicked()
        hoverEnabled: true

        onEntered: label.color = "#2f76dc"
        onExited: label.color = "#B9EFF8"
    }
}
