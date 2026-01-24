import Quickshell
import QtQuick
import QtQuick.Controls

Slider {
  id: control

  width: parent.width - 64
  height: 8

  value: pressed ? null : activePlayer.position
  to: activePlayer.length

  property color activeColor: theme.accent
  property color backgroundColor: theme.base00

  background: Rectangle {
    x: control.leftPadding
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: 200
    implicitHeight: 8
    height: implicitHeight
    radius: 8
    color: theme.base02

    Rectangle {
      width: control.visualPosition * parent.width
      height: parent.height
      color: activeColor
      radius: 8
    }
  }

  handle: Rectangle {
    x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
    y: control.topPadding + control.availableHeight / 2 - height / 2
    implicitWidth: control.hovered || control.pressed ? 26 : 16
    Behavior on implicitWidth {
      NumberAnimation {
        duration: 100
      }
    }
    implicitHeight: 26
    radius: 8
    color: control.hovered || control.pressed ? theme.accent : theme.base05
    border.width: 4
    border.color: backgroundColor
  }
}
