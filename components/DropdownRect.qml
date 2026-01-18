import Quickshell
import QtQuick

StyledRect {
  id: dropdown
  anchors.centerIn: null
  width: parent.width - 24
  height: parent.height
  x: 12
  y: popup.visible ? 0 : (settings.bar.side == 1 ? -height : height)
  Behavior on y {
    NumberAnimation {
      duration: 250
      easing.bezierCurve: settings.floating ? [0.38, 1.21, 0.22, 1, 1, 1] : [0.38, 1.0, 0.22, 1, 1, 1]
    }
  }
  Behavior on width {
    NumberAnimation {
      duration: 250
      easing.bezierCurve: [0.38, 1.0, 0.22, 1, 1, 1]
    }
  }
  color: theme.base00
  radius: 16

  topLeftRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
  topRightRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
  bottomLeftRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
  bottomRightRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
}
