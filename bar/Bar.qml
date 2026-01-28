import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

Scope {
  property string time

  Variants {
    model: Quickshell.screens

    PanelWindow {
      required property var modelData
      screen: modelData

      anchors {
        top: settings.bar.side != 4
        bottom: settings.bar.side != 1
        left: true
        right: true
      }

      implicitHeight: settings.floating ? 52 : 38

      color: "transparent"


      Rectangle {

        color: 'transparent'

        width: parent.width - (16 * settings.floating)
        height: parent.height - (16 * settings.floating)
        anchors.centerIn: parent

        RectangularShadow {
          anchors.fill: bar
          blur: 10
          radius: bar.radius
        }
        
        Rectangle {
          id: bar

          anchors.fill: parent

          color: theme.base00
          radius: settings.floating ? 20 : 0


          Rectangle {
            anchors.left: parent.left
            anchors.leftMargin: settings.floating ? 0 : 16

            color: theme.base01
            width: rowLeft.width + 8
            height: parent.height
            radius: 20

            RowLayout {
              id: rowLeft
              spacing: 2
              height: parent.height

              Time {}
              Media {}
              
            }
          }

          Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            color: theme.base01
            width: rowMiddle.width + 16
            height: parent.height
            radius: 16

            RowLayout {
              id: rowMiddle
              anchors.centerIn: parent
              spacing: 2
              height: parent.height

              Workspaces {}

            }
          }

          Rectangle {
            anchors.right: parent.right
            anchors.rightMargin: settings.floating ? 0 : 16

            color: theme.base01
            width: rowRight.width + 8
            height: parent.height
            radius: 20

            RowLayout {
              anchors.right: parent.right
              id: rowRight
              spacing: 2
              height: parent.height

              ThemeButton {}
              Temp {}
              Battery {}
              //Power {}

            }
          }
          /*
          Dropdown {
            id: popup
            visible: true
            anchor.item: bar
            color: 'transparent'
            implicitWidth: 200
            
            DropdownRect { 
              //MediaDropdown {} 
            }
          }
          */
        }
      }
      //Text {
      //  anchors.centerIn: parent
      //  text: Time.time
      //}
    }
  }
}
