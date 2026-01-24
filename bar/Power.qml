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
      text: 'power_settings_new'
      color: theme.base08
   }
    ButtonArea {
      onClicked: popup.toggle()
    }
  }
  Dropdown {
    id: popup
    anchor.item: root
    implicitWidth: 52 + 12 + 16
    implicitHeight: 128
    
    DropdownRect {
      id: dropdown

      PowerDropdown {}

    }
  }
}
