import QtQuick

Rectangle {
    id: root

    property string activeLabel: ""
    property string inactiveLabel: ""
    property bool active: false
    property color buttonColor: "#2f76dc"

    signal clicked()

    implicitWidth: 50
    implicitHeight: 50
    radius: 25

    color: active ? root.buttonColor : "#2E333F"
    border.width: 2
    border.color: root.buttonColor

    Text {
        anchors.centerIn: parent
        text: root.active ? root.activeLabel : root.inactiveLabel
        color: root.active ? "#2E333F" : root.buttonColor
        font.pixelSize: 20
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
