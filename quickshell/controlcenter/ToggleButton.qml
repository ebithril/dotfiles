import QtQuick

Rectangle {
    id: root

    property string activeLabel: ""
    property string inactiveLabel: ""
    property bool active: false
    property color color: "#2f76dc"

    signal clicked()

    implicitWidth: 50
    implicitHeight: 50
    radius: 25

    color: active ? root.color : "#2E333F"
    border.width: 2
    border.color: root.color

    Text {
        anchors.centerIn: parent
        text: root.active ? root.activeLabel : root.inactiveLabel
        color: root.active ? "#2E333F" : root.color
        font.pixelSize: 20
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
        cursorShape: Qt.PointingHandCursor
    }
}
