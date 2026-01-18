import Quickshell
import QtQuick
import QtQuick.Layouts
import '../components'

Rectangle {
  id: root
  color: 'transparent'
  Layout.fillHeight: true
  implicitWidth: height
  
  StyledRect {
    GoogleIcon {
      anchors.centerIn: parent
      text: 'format_paint'
      color: theme.accent
    }
    ButtonArea {
      onClicked: popup.visible = !popup.visible
    }
  }
  Dropdown {
    id: popup
    anchor.item: root
    implicitHeight: 512
    implicitWidth: 256

    DropdownRect {

      StyledRect {
        color: theme.base01
        edgeGap: 16
        ThemeDropdown {}
      
    }
  }
}
