import Quickshell
import QtQuick

MouseArea {
  anchors.fill: parent
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor
  onEntered: hover.start()
  onExited: unHover.start()

  property color hoverColor: theme.base03
  property color defColor: theme.base02

  ColorAnimation {
    id: hover
    target: parent
    property: "color"
    to: hoverColor
    duration: 100
  }

  ColorAnimation {
    id: unHover
    target: parent
    property: "color"
    to: defColor
    duration: 100
  }
}
