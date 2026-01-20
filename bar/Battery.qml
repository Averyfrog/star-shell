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
      (UPower.displayDevice.percentage <= 0.15 ? theme.base08 : theme.base0A) :
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
      onClicked: popup.toggle()
    }
  }

  Dropdown {
    id: popup
    anchor.item: root
    implicitHeight: 176 + bluetoothDevices.height + (bluetoothDevices.height > 10 ? 16 : 0)

    DropdownRect {

      StyledRect {
        color: theme.base01
        edgeGap: 16

        StyledRect {
          id: deviceInfo
          edgeGap: 16
          height: width
          anchors {
            centerIn: null
            top: parent.top
            topMargin: 8
            horizontalCenter: parent.horizontalCenter
          }
          CircularProgress {
            width: 64
            circleWidth: 8
            value: UPower.displayDevice.percentage
            foregroundColor: bat.batteryColor
            anchors {
              centerIn: null
              top: parent.top
              topMargin: 16
              left: parent.left
              leftMargin: 16
            }
          }
          Label {
            text: (UPower.displayDevice.percentage * 100).toFixed(0)
            color: bat.batteryColor
            font.pixelSize: 20
            anchors {
              centerIn: null
              top: parent.top
              topMargin: 34
              left: parent.left
              leftMargin: 34
            }
          }
          CircularProgress {
            width: 32
            circleWidth: 4
            value: 1
            foregroundColor: (UPower.displayDevice.state == UPowerDeviceState.Charging ||
              UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? theme.base0A : theme.base00
            anchors {
              centerIn: null
              top: parent.top
              topMargin: 16
              right: parent.right
              rightMargin: 16
            }
          }
          GoogleIcon {
            text: 'bolt'
            color: (UPower.displayDevice.state == UPowerDeviceState.Charging ||
              UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? theme.base0A : theme.base00
            font.pixelSize: 14
            anchors {
              centerIn: null
              top: parent.top
              topMargin: 24
              right: parent.right
              rightMargin: 25
            }
          }
          Label {
            text: ((UPower.displayDevice.state == UPowerDeviceState.Charging ||
              UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? 
              "" : "-") + UPower.displayDevice.changeRate.toFixed(1) + 'w'
            color: (UPower.displayDevice.state == UPowerDeviceState.Charging ||
              UPower.displayDevice.state == UPowerDeviceState.FullyCharged) ? theme.base0A : theme.base00
            anchors {
              centerIn: null
              top: parent.top
              topMargin: 60
              right: parent.right
              rightMargin: 12
            }
          }
          Rectangle {
            color: 'transparent'
            height: parent.height/2.8
            width: parent.width
            anchors.bottom: parent.bottom
            Label {
              anchors {
                centerIn: null
                top: parent.top
                topMargin: 4
                horizontalCenter: parent.horizontalCenter
              }
              text: UPower.displayDevice.state == UPowerDeviceState.Discharging ? "Time until death:" : "Time until full:"
              opacity: 0.7
              font.pixelSize: 12
            }
            Label {
              anchors {
                centerIn: null
                top: parent.top
                topMargin: 22
                horizontalCenter: parent.horizontalCenter
              }
              text: msToTime(UPower.displayDevice.state == UPowerDeviceState.Discharging ?
                UPower.displayDevice.timeToEmpty : UPower.displayDevice.timeToFull)
                
              function msToTime(s) {
                var secs = s % 60;
                s = (s - secs) / 60;
                var mins = s % 60;
                var hrs = (s - mins) / 60;

                return ("0" + hrs).slice(-2) + ':' + ("0" + mins).slice(-2);
              }
            }
          }
        }
        Rectangle {
          id: deviceLabel

          width: parent.width
          height: 16
          color: 'transparent'
  
          anchors.top: deviceInfo.bottom
          Label {
            text: '- Devices -'
            anchors.centerIn: parent
            opacity: bluetoothDevices.height > 10 ? 0.7 : 0.0
          }
        }
      
        ColumnLayout {
          id: bluetoothDevices
          anchors.top: deviceLabel.bottom
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
                spacing: 0
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
                  property string batteryColor: modelData.battery <= 0.3 ?
                    (modelData.battery <= 0.15 ? theme.base08 : theme.base0A) :
                    (modelData.battery >= 0.8 ? theme.base0B : theme.base0C)
                  color: 'transparent'
                  anchors.centerIn: null
                  height: 32
                  width: 32
                  Label {
                    anchors.centerIn: parent
                    text: (modelData.battery * 100).toFixed(0)
                    color: parent.batteryColor
                    opacity: 1
                    font.pixelSize: 10
                  }
                  CircularProgress {
                    width: 32
                    value: modelData.battery
                    foregroundColor: parent.batteryColor
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
