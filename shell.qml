import Quickshell
import Quickshell.Io
import QtQuick

import "bar"
import "notifications"

ShellRoot {
  FileView {
    id: themeFile
    path: Qt.resolvedUrl("./theme.json")
    watchChanges: true
    onFileChanged: {
      this.reload()
    }
    blockLoading: true
  }
  
  FileView {
    id: settingsFile
    path: Qt.resolvedUrl("./settings.json")
    watchChanges: true
    onFileChanged: {
      this.reload()
    }
    blockLoading: true
  }

  readonly property var theme: JSON.parse(themeFile.text()) 
  readonly property var settings: JSON.parse(settingsFile.text()) 

  Loader {
    Component { id: border; Border {}}
    sourceComponent: settings.floating ? null : border
  }
  Bar {}
  NotifPanel {}
}
