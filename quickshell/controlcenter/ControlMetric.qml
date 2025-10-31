import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root
    spacing: 10

    property string label: ""
    property real value: 0
    signal valueChanged(real newValue)

    Text {
        text: root.label
        color: "#E62C39"  // crimson
        font.pixelSize: 16
    }

    Slider {
        Layout.fillWidth: true
        Layout.preferredWidth: 275

        from: 0
        to: 100
        value: root.value

        onValueChanged: {
            root.valueChanged(value)
        }

        background: Rectangle {
            x: parent.leftPadding
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 8
            width: parent.availableWidth
            height: implicitHeight
            radius: 50
            color: "#4A4F5B"  // lighter grey

            Rectangle {
                width: parent.parent.visualPosition * parent.width
                height: parent.height
                color: "#E62C39"  // crimson
                radius: 10
            }
        }

        handle: Rectangle {
            x: parent.leftPadding + parent.visualPosition * (parent.availableWidth - width)
            y: parent.topPadding + parent.availableHeight / 2 - height / 2
            implicitWidth: 20
            implicitHeight: 20
            radius: 10
            color: "#E62C39"  // crimson
        }
    }
}
