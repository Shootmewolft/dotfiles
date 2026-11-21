pragma ComponentBehavior: Bound
import "vim_cheatsheet.js" as VimSheet

import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import Quickshell

Item {
    id: root
    property string query: ""

    function filterItems(section) {
        const items = section.items;
        if (root.query.length === 0 || section.title.toLowerCase().includes(root.query)) return items;
        return items.filter(item => typeof item !== "string"
            && (item[0] + " " + item[1]).toLowerCase().includes(root.query));
    }
    implicitWidth: QsWindow?.window?.screen.width * 0.7 ?? 0
    implicitHeight: QsWindow?.window?.screen.height * 0.7 ?? 0

    StyledFlickable {
        id: flickable
        clip: true
        anchors.fill: parent
        anchors.margins: Appearance.rounding.small
        contentHeight: height
        contentWidth: flow.implicitWidth
        Flow {
            id: flow
            height: flickable.height
            flow: Flow.TopToBottom
            spacing: 10
            Repeater {
                model: VimSheet.sections
                delegate: VimSection {}
            }
        }
    }

    ScrollEdgeFade {
        target: flickable
        vertical: false
        color: Appearance.colors.colLayer0Base
    }

    component VimSection: Column {
        id: section
        required property var modelData
        readonly property var visibleItems: root.filterItems(modelData)
        property real keyColumnWidth: 0
        visible: visibleItems.length > 0
        spacing: 4
        bottomPadding: 6

        StyledText {
            text: section.modelData.title
            font.pixelSize: Appearance.font.pixelSize.title
            bottomPadding: 3
        }

        Repeater {
            model: section.visibleItems
            delegate: Loader {
                id: itemLoader
                required property var modelData
                sourceComponent: typeof modelData === "string" ? subheading : bindLine

                Component {
                    id: subheading
                    StyledText {
                        topPadding: 4
                        text: itemLoader.modelData
                        color: Appearance.colors.colSubtext
                        font.pixelSize: Appearance.font.pixelSize.smaller
                        font.weight: Font.DemiBold
                    }
                }

                Component {
                    id: bindLine
                    Row {
                        spacing: 16
                        Item {
                            width: Math.max(section.keyColumnWidth, key.implicitWidth)
                            implicitHeight: key.implicitHeight
                            KeyboardKey {
                                id: key
                                key: itemLoader.modelData[0]
                                pixelSize: Config.options.cheatsheet.fontSize.key
                                color: Appearance.colors.colOnLayer0
                                Component.onCompleted: section.keyColumnWidth = Math.max(section.keyColumnWidth, implicitWidth)
                            }
                        }
                        StyledText {
                            anchors.verticalCenter: parent.verticalCenter
                            rightPadding: 40
                            font.pixelSize: Config.options.cheatsheet.fontSize.comment || Appearance.font.pixelSize.smaller
                            text: itemLoader.modelData[1]
                        }
                    }
                }
            }
        }
    }
}
