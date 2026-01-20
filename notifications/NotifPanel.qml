import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import '../components'

Scope {
  PanelWindow {
    id: panel

    WlrLayershell.layer: WlrLayer.Overlay

    anchors {
      bottom: true
      right: true
    }
  
    implicitWidth: 400
    implicitHeight: notifColumn.height + 8
    color: 'transparent'

    ColumnLayout {
      id: notifColumn
      spacing: 8
      width: parent.width

      Connections {
        target: NotificationServer{
          onNotification:(n)=>{
            n.tracked = true
          }
        }
      }
      
      Repeater {
        model: NotifServer.shownNotifs
        delegate: Notif { }
      }
    }
  }
}
