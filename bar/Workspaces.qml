import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
  color: 'transparent'
  radius: 24
  Layout.fillHeight: true

  implicitWidth: ((settings.workspaces.count-1) * 28) + 52 + ((settings.workspaces.count+1)*workspaceRow.spacing)
  //width: childrenRect.width

  Row {
    id: workspaceRow
    spacing: 4
    height: parent.height
    anchors.centerIn: parent

    Repeater {
      model: settings.workspaces.count

      Rectangle {
        width: isActive ? 52 : 28
        height: parent.height - 8
        anchors.verticalCenter: parent.verticalCenter
        
        property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
        property string wsColor: {
          switch (index+1) {
            case 1: return theme.base08
            case 2: return theme.base09
            case 3: return theme.base0A
            case 4: return theme.base0B
            case 5: return theme.base0C
            case 6: return theme.base0D
            case 7: return theme.base0E
            case 8: return theme.base0F
            case 9: return theme.base0F
          }
        }
        property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
        //color: isActive ? palette.active.accent : (ws ? palette.active.linkVisited : "#444b6a")
        color: isActive ? wsColor : theme.base02
        
        bottomLeftRadius: (index == 0) ? 16 : 8
        topLeftRadius: (index == 0) ? 16 : 8
        bottomRightRadius: (index == settings.workspaces.count-1) ? 16 : 8
        topRightRadius: (index == settings.workspaces.count-1) ? 16 : 8

        MouseArea {
              anchors.fill: parent
              onClicked: Hyprland.dispatch("workspace " + (index + 1))
              cursorShape: Qt.PointingHandCursor
        }

        Text {
          anchors.centerIn: parent
          text: {
            return settings.workspaces.icons[index]
            switch (index+1) {
              case 1: return "Web"
              case 2: return "Forum"
              case 3: return "Terminal"
              case 4: return "Category"
              case 5: return "Deployed_Code"
              case 6: return "Add"
            }
          }
          color: isActive ? theme.base00 : wsColor
          font {
            pixelSize: 14;
            bold: true
            family: "Material Symbols Rounded"
            weight: 700
            styleName: "Normal"
          }
        }
      }
    }
  }
}
