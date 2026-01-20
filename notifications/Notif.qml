import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import '../components'

Rectangle {
  id: root
  width: 400 - 8
  height: notifContent.implicitHeight + 64

  required property QtObject modelData
  property Notification notif: modelData.notification

  property string title: notif.summary
  property string content: notif.body

  color: 'transparent'

  StyledRect {
    id: rect
    anchors.centerIn: null
    //Layout.alignment: Qt.AlignLeft
    height: notifContent.implicitHeight + 64
    width: 400 - 8
    
    border {
      width: modelData.pinned ? 2 : 0
      color: theme.base0C
    }

    opacity: (width - x) / width

    x: mouseArea.drag.active ? null : 0

    Timer {
      id: notifTimeout
      interval: 10
      running: !modelData.pinned
      repeat: true
      onTriggered: {
        if (modelData.timeLeft > 0) {
          modelData.timeLeft -= 0.01
        }
        else if (!modelData.pinned) {
          notif.dismiss()
          NotifServer.remove(notif.id)
        }
      }
    }
  
    CircularProgress {
      anchors {
        centerIn: null
        bottom: parent.bottom
        bottomMargin: 8
        right: parent.right
        rightMargin: 8
      }
      id: timeProgress
      width: 32
      value: modelData.timeLeft/modelData.totalTime
    }

    ButtonArea {
      id: mouseArea
      cursorShape: Qt.PointingHandCursor
      drag.target: rect
      drag.axis: Drag.XAxis
      drag.minimumX: 0
      drag.maximumX: rect.width + 16
      hoverColor: theme.base02
      onReleased: {
        if (rect.x > rect.width/2) {
          notif.expire()
          NotifServer.remove(notif.id)
        }
      }
    }
    
    Rectangle {
      color: 'transparent'
      height: parent.height
      width: parent.width - (notif.image != "" ? 128 : 0)
      anchors.right: parent.right

      Label {
        width: 200
        anchors {
          top: parent.top
          topMargin: 8
          left: parent.left
          leftMargin: 8
        }
        text: title
        color: theme.accent
        font.pixelSize: 16
      }

      Text {
        id: notifContent
        anchors {
          top: parent.top
          topMargin: 32
          left: parent.left
          leftMargin: 8
        }

        wrapMode: Text.WordWrap
        elide: Text.ElideRight
        maximumLineCount: 20
        width: parent.width - 56
        //height: implicitHeight
        text: content
        color: theme.base05
        font.pixelSize: 14
      }
      Rectangle {
        anchors {
          top: parent.top
          topMargin: 8
          right: parent.right
          rightMargin: 8
        }
        width: 16
        height: width
        radius: 16
        color: theme.base08
          ButtonArea {
            defColor: theme.base08
            onClicked: {
              notif.dismiss()
              NotifServer.remove(notif.id)
            }
          }
          GoogleIcon {
            color: theme.base08
            text: 'close'
            font.pixelSize: 12
            anchors.centerIn: parent
          }
      }
      Rectangle {
        anchors {
          top: parent.top
          topMargin: 8
          right: parent.right
          rightMargin: 32
        }
        width: 16
        height: width
        radius: 16
        color: theme.base0A
          ButtonArea {
            defColor: theme.base0A
            onClicked: {
              NotifServer.remove(notif.id)
              notif.dismiss()
            }
          }
          GoogleIcon {
            color: theme.base0A
            text: 'pinboard'
            font.pixelSize: 12
            anchors.centerIn: parent
          }
      }
      Rectangle {
        anchors {
          top: parent.top
          topMargin: 8
          right: parent.right
          rightMargin: 56
        }
        width: 16
        height: width
        radius: 16
        color: theme.base0C
          ButtonArea {
            defColor: theme.base0C
            onClicked: {
              modelData.pinned = !modelData.pinned
            }
          }
          GoogleIcon {
            color: theme.base0C
            text: 'keep'
            font.pixelSize: 12
            anchors.centerIn: parent
          }
      }
    }
  }
}
