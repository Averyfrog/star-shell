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
      onClicked: popup.visible = !popup.visible
    }
  }

  Dropdown {
    id: popup
    anchor.item: root

    DropdownRect {

      StyledRect {
        color: theme.base01
        edgeGap: 16
      
        ColumnLayout {
          anchors.top: parent.top
          anchors.topMargin: 8
          width: parent.width
          //height: parent.height - 16
          

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
                spacing: 4
                anchors.centerIn: parent
                width: parent.width-8
                height: parent.height-8
                StyledRect {
                  color: 'transparent'
                  anchors.centerIn: null
                  width: parent.width/1.5
                  Label {
                    width: parent.width
                    text: modelData.name + ":"
                    font.pixelSize: 12
                  }
                }
                StyledRect {
                  color: 'transparent'
                  anchors.centerIn: null
                  height: 32
                  Label {
                    text: (modelData.battery * 100).toFixed(0) + "%"
                    color: theme.base0C
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
