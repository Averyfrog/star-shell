import Quickshell
import QtQuick
import QtQuick.Layouts
import '../components'

StyledRect {
  edgeGap: 16
  ColumnLayout {
    anchors.fill: parent
    anchors.leftMargin: 4
    anchors.topMargin: 4
    anchors.bottomMargin: 4
    StyledRect {
      color: theme.base0B
      id: lock
      anchors.centerIn: null
      edgeGap: 0
      width: 32
      height: width
      GoogleIcon {
        anchors.centerIn: parent
        text: 'lock'
        color: theme.base00
        font.pixelSize: 20
      }
    }
    StyledRect {
      color: theme.base09
      id: sleep
      anchors.centerIn: null
      edgeGap: 0
      width: 32
      height: width
    }
    StyledRect {
      id: off
      color: theme.base08
      anchors.centerIn: null
      edgeGap: 0
      width: 32
      height: width
    }
  }
}
