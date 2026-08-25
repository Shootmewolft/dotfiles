import qs.services
import qs.modules.common
import qs.modules.common.widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: Appearance.rounding.normal
            color: Appearance.colors.colLayer1

            ScrollView {
                anchors.fill: parent
                anchors.margins: 10
                clip: true

                StyledTextArea {
                    id: notesArea
                    wrapMode: TextArea.Wrap
                    placeholderText: Translation.tr("Type your notes here...")
                    text: Notes.text
                    onTextChanged: {
                        if (text !== Notes.text) Notes.setText(text)
                    }
                }
            }
        }
    }
}
