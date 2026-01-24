import Quickshell
import QtQuick

Text {
  id: label
  anchors.verticalCenter: parent.verticalCenter
  color: theme.base05
  elide: Text.ElideRight
  font {
    bold: true
  }
  //clip: true
  Behavior on color {
    ColorAnimation {
      duration: 250 / settings.animationSpeed
    }
  }
}
