import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
  
  id: root
  
  color: 'transparent'

  Layout.fillHeight: true
  width: 76

  Rectangle {
    color: theme.base02

    height: parent.height - 8
    width: parent.width - 8
    anchors.centerIn: parent
    radius: 16

    Row {
      id: clockRow
      anchors.centerIn: parent
      spacing: 2

      Text {
        anchors.verticalCenter: parent.verticalCenter
        font {
          pixelSize: 16;
          bold: true
          family: "Material Symbols Rounded"
          weight: 700
          styleName: "Normal"
        }
        color: theme.base0E

        text: "Schedule"
      }

      Text {
        anchors.verticalCenter: parent.verticalCenter
        color: theme.base0E
        text: Qt.formatDateTime(clock.date, settings.time.format)
        font {
          bold: true
        }
      }
    }
  }
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
