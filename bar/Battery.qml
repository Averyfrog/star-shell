import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts
import '../components'

Rectangle {
  id: root
  Layout.fillHeight: true
  color: 'transparent'

  implicitWidth: settings.battery.showPercentage ? 76 : 42

  StyledRect {
    id: bat

    property int batteryStage: ((UPower.displayDevice.percentage * 6) + 1).toFixed(0)
    property string batteryColor: UPower.displayDevice.percentage <= 0.3 ?
      (UPower.displayDevice.percentage <= 0.1 ? theme.base08 : theme.base0A) :
      (UPower.displayDevice.percentage >= 0.8 ? theme.base0B : theme.base0C)

    Row {
      id: batteryRow
      anchors.centerIn: parent
      spacing: 2

      GoogleIcon {
        font {
          pixelSize: 22;
          bold: false
        }
        color: bat.batteryColor

        text: {
          if (UPower.displayDevice.state == UPowerDeviceState.Charging ||
              UPower.displayDevice.state == UPowerDeviceState.FullyCharged) {
            return "battery_android_frame_bolt"
          }

          if (UPower.displayDevice.state == UPowerDeviceState.FullyCharged ||
              bat.batteryStage == 7) {
            return "battery_android_frame_full"
          }
          return "battery_android_frame_" + bat.batteryStage
        }
      }

      Label {
text: settings.battery.showPercentage ?(UPower.displayDevice.percentage * 100).toFixed(0) + "%" : ""
        color: bat.batteryColor
      }
    }
    
    ButtonArea {
      onClicked: dropdown.show = !dropdown.show
    }
  }

  Dropdown {
    id: dropdown
    anchor.item: root
    property bool show: false

    visible: true
    StyledRect {
      anchors.centerIn: null
      x: 12
      y: dropdown.show ? 0 : (settings.bar.side == 1 ? -height : height)
      Behavior on y {
        NumberAnimation {
          duration: 250
          easing.bezierCurve: settings.floating ? [0.38, 1.21, 0.22, 1, 1, 1] : [0.38, 1.0, 0.22, 1, 1, 1]
        }
      }
      width: dropdown.width - 24
      height: dropdown.height
      color: theme.base00

      topLeftRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      topRightRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      bottomLeftRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
      bottomRightRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius

      StyledRect {
        color: theme.base01
        edgeGap: 16
      
        ColumnLayout {
          anchors.centerIn: parent
          width: parent.width
          height: parent.height - 16
          

          Repeater {
            model: ScriptModel {
              values: Bluetooth.devices.values.filter(entry => entry.connected)
            }
            delegate: StyledRect {
              anchors.centerIn: null
              edgeGap: 16
              height: 48
              Layout.alignment: Qt.AlignHCenter
              RowLayout {
                anchors.centerIn: parent
                width: parent.width-8
                height: parent.height-8
                StyledRect {
                  color: 'transparent'
                  anchors.centerIn: null
                  width: parent.width/1.5
                  Label {
                    text: modelData.name
                  }
                }
                StyledRect {
                  color: 'transparent'
                  anchors.centerIn: null
                  height: 32
                  Label {
                    text: modelData.battery
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
