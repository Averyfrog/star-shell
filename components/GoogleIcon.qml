import Quickshell
import QtQuick

Text {
  id: icon
  anchors.verticalCenter: parent.verticalCenter
  font {
    pixelSize: 16;
    bold: false
    family: "Material Symbols Rounded"
    weight: 700
    styleName: "Normal"
  }
        
  color: theme.base05

  text: "add_circle"

  Behavior on color {
    ColorAnimation {
      duration: 250 / settings.animationSpeed
    }
  }
}
