import Quickshell
import QtQuick
import QtQuick.Layouts
import '../components'

FloatingWindow {
  id: root
  minimumSize: Qt.size(750, 500)
  color: theme.base00
  title: "star-shell Settings"

  property int currentMenu: 1
  
  property list<string> menus: [
    "settings General",
    "bottom_navigation Bar"
  ]

  RowLayout {
    anchors.fill: parent
    Rectangle {

      Layout.fillHeight: true
      width: 200
      color: theme.base01

      ColumnLayout {
        width: parent.width

        Label {
          text: root.title
          Layout.topMargin: 20
          Layout.leftMargin: 20
          font.pixelSize: 16
          Layout.bottomMargin: 16
        }

        Repeater {
          model: root.menus
          delegate: StyledRect {
            Layout.leftMargin: edgeGap/2
            edgeGap: 16
            anchors.centerIn: null
            height: 40

            color: index == currentMenu ? theme.accent : theme.base02

            radius: 4
            topLeftRadius: index == 0 ? 16 : 4
            topRightRadius: index == 0 ? 16 : 4
            bottomLeftRadius: index == root.menus.length-1 ? 16 : 4
            bottomRightRadius: index == root.menus.length-1 ? 16 : 4

            GoogleIcon {
              text: modelData.split(' ')[0]
              anchors.left: parent.left
              anchors.verticalCenter: parent.verticalCenter
              anchors.leftMargin: 8
              font.pixelSize: 18
              color: index == currentMenu ? theme.base02 : theme.base04
            }

            Label {
              anchors.verticalCenter: parent.verticalCenter
              anchors.left: parent.left
              anchors.leftMargin: 32
              text: modelData.split(' ')[1]
              font.bold: false
              color: index == currentMenu ? theme.base00 : theme.base05
            }

            ButtonArea {
              onClicked: root.currentMenu = index
              defColor: index == currentMenu ? theme.accent : theme.base02
            }
          }
        }
      }
    }
    Rectangle {
      Layout.fillHeight: true
      Layout.fillWidth: true
      color: 'transparent'
    }
  }
}
