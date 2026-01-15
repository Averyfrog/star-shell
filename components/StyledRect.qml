import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts


Rectangle {
    id: button
    color: theme.base02

    property int edgeGap: 8

    height: parent.height - edgeGap
    width: parent.width - edgeGap
    Behavior on width {
      NumberAnimation {
        duration: 100
      }
    }
    anchors.centerIn: parent
    radius: 16
}
