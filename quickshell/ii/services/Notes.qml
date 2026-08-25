pragma Singleton
pragma ComponentBehavior: Bound

import qs.modules.common
import Quickshell
import Quickshell.Io
import QtQuick

/**
 * Simple persisted scratch notes for the sidebar.
 */
Singleton {
    id: root
    property var filePath: `${Directories.state}/user/notes.txt`
    property string text: ""

    function setText(newText) {
        root.text = newText
        saveTimer.restart()
    }

    Timer {
        id: saveTimer
        interval: 400
        repeat: false
        onTriggered: notesFileView.setText(root.text)
    }

    FileView {
        id: notesFileView
        path: Qt.resolvedUrl(root.filePath)
        onLoaded: {
            root.text = notesFileView.text()
        }
        onLoadFailed: (error) => {
            if (error == FileViewError.FileNotFound) {
                root.text = ""
                notesFileView.setText(root.text)
            }
        }
    }

    Component.onCompleted: {
        notesFileView.reload()
    }
}
