import Quickshell
import QtQuick
import QtQuick.Layouts
import '../components'

Rectangle {
  color: 'transparent'
  Layout.fillHeight: true
  width: 40
  StyledRect {
    GoogleIcon {
      anchors.centerIn: parent
      anchors.verticalCenterOffset: 1
      text: "account_circle"
      color: theme.base03
      font { pixelSize: 20 }
    }
    Image {
      id: img
      width: parent.width
      height: parent.height
      anchors.centerIn: parent
      source: "/var/lib/AccountsService/icons/avafrog"
      fillMode: Image.PreserveAspectFit
    }
    ButtonArea {}
  }
}
