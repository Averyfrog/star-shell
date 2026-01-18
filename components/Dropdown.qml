import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

PopupWindow {
  anchor {
    rect.x: anchor.item.width/2 - width/2
    rect.y: settings.bar.side == 1 ? (settings.floating ? 52 : 36) : (settings.floating ? -implicitHeight - 16 : -implicitHeight + 1)
  }
  implicitWidth: 200
  implicitHeight: 200
  color: 'transparent'
}
