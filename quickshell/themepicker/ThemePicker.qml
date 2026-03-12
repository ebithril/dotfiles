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
            tryFocus();
        }
    }

    function tryFocus() {
        if (!initialFocusSet) {
            // Wait until the model has loaded enough items to actually reach our target
            if (view.count > targetWallIndex) {
                view.currentIndex = targetWallIndex;
                view.positionViewAtIndex(targetWallIndex, ListView.Center);
                initialFocusSet = true;
            } else if (folderModel.status === FolderListModel.Ready && view.count > 0) {
                // Fallback: If the folder completely finished loading but the index is somehow out of bounds
                let safeIndex = Math.max(0, view.count - 1);
                view.currentIndex = safeIndex;
                view.positionViewAtIndex(safeIndex, ListView.Center);
                initialFocusSet = true;
            }
        }
    }

    readonly property int scaledScreenWidth: Hyprland.focusedMonitor.width / Hyprland.focusedMonitor.scale
    readonly property int itemWidth: scaledScreenWidth / 10
    readonly property double itemRatio: 1414 / 1000
    readonly property int itemHeight: itemWidth * itemRatio
    readonly property int borderWidth: 3
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
        implicitWidth: root.scaledScreenWidth
        implicitHeight: root.itemHeight * 1.15
        color: "transparent"
        ListView {
            id: view
            anchors.fill: parent
            anchors.margins: 0

            spacing: root.spacing
            orientation: ListView.Horizontal
            clip: false

            // Pre-load items off-screen so they don't block the thread as they enter the view
            cacheBuffer: 2000

            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: (width / 2) - (root.itemWidth / 2)
            preferredHighlightEnd: (width / 2) + (root.itemWidth / 2)

            // Reset back to standard speed for snappy manual keyboard navigation
            highlightMoveDuration: root.initialFocusSet ? 300 : 0

            focus: true

            onCountChanged: root.tryFocus()

            model: ListModel {
                ListElement {
                    name: "luffy"
                }
                ListElement {
                    name: "zoro"
                }
                ListElement {
                    name: "nami"
                }
                ListElement {
                    name: "usopp"
                }
                ListElement {
                    name: "sanji"
                }
                ListElement {
                    name: "chopper"
                }
                ListElement {
                    name: "robin"
                }
                ListElement {
                    name: "franky"
                }
                ListElement {
                    name: "brook"
                }
                ListElement {
                    name: "jinbe"
                }
            }

            delegate: Item {
                id: delegateRoot
                width: root.itemWidth
                height: root.itemHeight
                anchors.verticalCenter: parent.verticalCenter

                readonly property bool isCurrent: ListView.isCurrentItem
                readonly property bool isVideo: false

                z: isCurrent ? 10 : 1

                function pickWallpaper() {
                    Theme.currentTheme = name;
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        view.currentIndex = index;
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
                            source: Theme.themes[name].wanted

                            // Load from disk on a background thread to prevent UI freezing
                            asynchronous: true
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
