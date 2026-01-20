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
  
  visible: false
  property bool show: false

  function toggle() {
    if (!popup.show) {
      visible = true
      show = true
    }
    else {
      show = false
      popupCloser.start()
    }
  }
  
  Timer {
    id: popupCloser
    interval: 100
    running: false
    onTriggered: visible = false
  }
}
