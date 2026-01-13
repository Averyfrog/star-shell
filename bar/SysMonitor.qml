import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../components"


BarIconInfo {
  id: root
  icon: "Thermostat"
  info: tempMonitor.info/1000 + "°"
  textColor: theme.base09
  implicitWidth: 72

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

