import Quickshell
import QtQuick

MouseArea {
  anchors.fill: parent
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor
  onEntered: ColorAnimation {
    target: parent
    property: "color"
    to: theme.base03
    duration: 100
  }
  onExited: ColorAnimation {
    target: parent
    property: "color"
    to: theme.base02
    duration: 100
  }
}
