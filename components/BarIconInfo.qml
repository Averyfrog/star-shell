import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Rectangle {
  
  id: root

  required property string icon
  required property string info
  required property string textColor
  property string iconColor
  
  color: 'transparent'

  Layout.fillHeight: true
  implicitWidth: label.implicitWidth + icon.implicitWidth + 32

  Rectangle {
    id: rect
    color: theme.base02

    height: parent.height - 8
    width: parent.width - 8
    anchors.centerIn: parent
    radius: 16

    Row {
      anchors.centerIn: parent
      spacing: 2

      Text {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        font {
          pixelSize: 16;
          bold: true
          family: "Material Symbols Rounded"
          weight: 700
          styleName: "Normal"
        }
        
        color: root.iconColor ? root.iconColor : root.textColor

        text: root.icon
      }

      Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        color: root.textColor
        font {
          bold: true
        }

        text: root.info
      }
    }
  }
}
