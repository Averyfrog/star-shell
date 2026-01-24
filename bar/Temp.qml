import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../components"

Rectangle {
  id: root

  color: 'transparent'
  implicitWidth: button.implicitWidth
  Layout.fillHeight: true

  
  StyledRect {
    id: button
    implicitWidth: 72

    Row {
      spacing: 4
      anchors.centerIn: parent  
      GoogleIcon {
        text: "Thermostat"
        color: theme.base09
      }
      Label {
        text: tempMonitor.info/1000 + "°"
        color: theme.base09
      }
    }
  }

  Process {
    id: tempMonitor
    property string info
    running: true
    command: [ "cat", "/sys/devices/virtual/thermal/thermal_zone0/temp" ]
    //command: [ "date" ]
    stdout: StdioCollector {
      onStreamFinished: tempMonitor.info = this.text
    }
  }

  Timer {
    id: clock
    interval: 10000
    running: true
    repeat: true
    onTriggered: tempMonitor.running = true
  }
}

