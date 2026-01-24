import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

PopupWindow {
  anchor {
    rect.x: anchor.item.width/2 - width/2
    rect.y: settings.bar.side == 1 ? (settings.floating ? 52 : 37) : (settings.floating ? -implicitHeight - 16 : -implicitHeight + 1)
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
    interval: (250 * implicitHeight/200) / settings.animationSpeed
    running: false
    onTriggered: visible = show
  }
}
