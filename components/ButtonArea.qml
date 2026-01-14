import Quickshell
import QtQuick

MouseArea {
  anchors.fill: parent
  hoverEnabled: true
  cursorShape: Qt.PointingHandCursor
  onEntered: hover.start()
  onExited: unHover.start()

  ColorAnimation {
    id: hover
    target: parent
    property: "color"
    to: theme.base03
    duration: 100
  }

  ColorAnimation {
    id: unHover
    target: parent
    property: "color"
    to: theme.base02
    duration: 100
  }
}
