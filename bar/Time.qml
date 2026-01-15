import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import '../components'

Rectangle {
  
  id: root
  
  color: 'transparent'

  Layout.fillHeight: true
  width: 76

  StyledRect {
    
    Row {
      id: clockRow
      anchors.centerIn: parent
      spacing: 2

      GoogleIcon {
        text: "Schedule"
        color: theme.base0E
      }
      Label {
        color: theme.base0E
        text: Qt.formatDateTime(clock.date, settings.time.format)
      }
    }
  }
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
