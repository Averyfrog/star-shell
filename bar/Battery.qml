import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: root
  Layout.fillHeight: true
  color: 'transparent'

  width: 76

  Rectangle {
    id: bat
    height: parent.height - 8
    width: parent.width - 8
    radius: 16

    color: theme.base02

    anchors.centerIn: parent

    property int batteryStage: ((UPower.displayDevice.percentage * 6) + 1).toFixed(0)
    property string batteryColor: UPower.displayDevice.percentage <= 0.3 ?
      (UPower.displayDevice.percentage <= 0.1 ? theme.base08 : theme.base0A) :
      (UPower.displayDevice.percentage >= 0.8 ? theme.base0B : theme.base0C)


    Row {
      id: batteryRow
      anchors.centerIn: parent
      spacing: 2

      Text {
        anchors.verticalCenter: parent.verticalCenter
        font {
          pixelSize: 22;
          bold: false
          family: "Material Symbols Rounded"
          weight: 400
          styleName: "Normal"
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

      Text {
        anchors.verticalCenter: parent.verticalCenter
        text: (UPower.displayDevice.percentage * 100).toFixed(0) + "%"
        color: bat.batteryColor
        font {
          bold: true
        }
      }

    }
  }

  PopupWindow {
    anchor {
      item: root
      rect.x: - width/2
    }
    implicitWidth: 500
    implicitHeight: 500
    visible: false
  }
}
