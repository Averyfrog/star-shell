import Quickshell
import QtQuick

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
