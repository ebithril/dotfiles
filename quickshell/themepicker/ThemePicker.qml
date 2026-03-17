import QtQuick
import QtQuick.Layouts
import Qt.labs.folderlistmodel
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Scope {
    id: root

    // -------------------------------------------------------------------------
    // PROPERTIES & IPC RECEIVER
    // -------------------------------------------------------------------------
    property string widgetArg: ""
    property int targetWallIndex: 0
    property bool initialFocusSet: false
    property bool shown: false

    onWidgetArgChanged: {
        let idx = parseInt(widgetArg);
        if (!isNaN(idx)) {
            targetWallIndex = idx;
        }
    }

    readonly property int borderWidth: 3
    readonly property int scaledScreenWidth: Hyprland.focusedMonitor.width / Hyprland.focusedMonitor.scale
    readonly property int switcherWidth: scaledScreenWidth - 100
    readonly property int itemWidth: switcherWidth / 10 - ((borderWidth * 11) / 10)
    readonly property double itemRatio: 1414 / 1000
    readonly property int itemHeight: itemWidth * itemRatio
    readonly property int spacing: 0
    readonly property real skewFactor: 0

    Shortcut {
        sequence: "Left"
        onActivated: view.decrementCurrentIndex()
    }
    Shortcut {
        sequence: "Right"
        onActivated: view.incrementCurrentIndex()
    }
    Shortcut {
        sequence: "Return"
        onActivated: {
            if (view.currentItem)
                view.currentItem.pickWallpaper();
        }
    }

    // -------------------------------------------------------------------------
    // CONTENT
    // -------------------------------------------------------------------------
    PanelWindow {
        visible: root.shown
        implicitWidth: root.switcherWidth + root.itemWidth * 0.15
        implicitHeight: root.itemHeight * 1.15
        color: "transparent"
        RowLayout {
            Repeater {
                id: view
                clip: false

                // Pre-load items off-screen so they don't block the thread as they enter the view

                // Reset back to standard speed for snappy manual keyboard navigation

                focus: true

                model: Theme.themeNames
                delegate: Item {
                    id: delegateRoot
                    required property string modelData
                    width: root.itemWidth
                    height: root.itemHeight

                    readonly property bool isCurrent: Theme.currentTheme == modelData
                    z: isCurrent ? 10 : 1

                    function pickWallpaper() {
                        Theme.currentTheme = modelData;
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            root.shown = false;
                        }
                        onEntered: {
                            delegateRoot.pickWallpaper();
                        }
                    }

                    Item {
                        anchors.centerIn: parent
                        width: parent.width
                        height: parent.height

                        scale: delegateRoot.isCurrent ? 1.15 : 0.95
                        opacity: delegateRoot.isCurrent ? 1.0 : 0.6

                        Behavior on scale {
                            NumberAnimation {
                                duration: 500
                                easing.type: Easing.OutBack
                            }
                        }
                        Behavior on opacity {
                            NumberAnimation {
                                duration: 500
                            }
                        }

                        Item {
                            anchors.fill: parent
                            anchors.margins: root.borderWidth

                            Rectangle {
                                anchors.fill: parent
                                color: "black"
                            }
                            clip: true

                            Image {
                                anchors.centerIn: parent

                                width: parent.width
                                height: parent.height

                                fillMode: Image.Stretch
                                source: Theme.themes[delegateRoot.modelData].wanted

                                // Load from disk on a background thread to prevent UI freezing
                                asynchronous: true
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        view.forceActiveFocus();
    }
}
