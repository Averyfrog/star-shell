import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris 
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes
import '../components'

Rectangle {
  
  id: root

  readonly property MprisPlayer activePlayer: Mpris.players.values[0]
  
  color: 'transparent'

  Layout.fillHeight: true

  implicitWidth: mediaRow.width + 8

  Row {
    id: mediaRow
    spacing: 4
    anchors.centerIn: parent
    height: parent.height

    StyledRect {
      id: song

      anchors.centerIn: null      
      anchors.verticalCenter: parent.verticalCenter

      width: musicRow.width + 16

      topRightRadius: 8
      bottomRightRadius: 8

      ButtonArea {
        onClicked: { 
          popup.visible = !popup.visible
        }
      }

      Row {
        id: musicRow
        anchors.centerIn: parent
        spacing: 4

        Label {
          width: Math.min(200, implicitWidth)
          text: activePlayer == null ? "Nothing" : activePlayer.trackTitle
          color: theme.accent
        }

        GoogleIcon {
          color: theme.accent
          text: "music_note"
        }

        Label {
          width: Math.min(160, implicitWidth)
          color: theme.accent
          opacity: 0.7
          text: activePlayer == null ? "Nobody" : activePlayer.trackArtist
        }
      }
    }

    StyledRect {
      width: height

      anchors.centerIn: null
      anchors.verticalCenter: parent.verticalCenter

      topLeftRadius: 8
      bottomLeftRadius: 8
      
      ButtonArea {
        onClicked: activePlayer.togglePlaying()
      }

      GoogleIcon {
        anchors.centerIn: parent
        text: activePlayer != null && activePlayer.isPlaying ? "pause" : "play_arrow"
        color: activePlayer == null ? theme.base01 : theme.accent
      }
    }
  }

  Dropdown {
    id: popup
    anchor.item: root
    implicitWidth: 616
    implicitHeight: 200
    
    property bool show: true
    visible: false

    DropdownRect {
      id: dropdown

      MediaDropdown {}

    }
  }
}
