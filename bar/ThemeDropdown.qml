import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import '../components'

ColumnLayout {
  anchors.centerIn: parent
  width: parent.width
  height: parent.height - 16
          
  Repeater {
    model: ScriptModel {
      values: themeVariants
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
          width: parent.width
          Label {
            text: modelData.name
          }
        }
      }
      Process {
        id: themeCommand
        property string info
        running: false
        command: [ "config-manager", modelData.command ]
      }
      ButtonArea {
        onClicked: {
          themeCommand.running = true
          popup.visible = false
        }
      }
    }
  }
}
