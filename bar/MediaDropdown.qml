import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import '../components'

      StyledRect {

        readonly property MprisPlayer activePlayer: Mpris.players.values[0]
        width: parent.width - 16
        height: parent.height - 16
        color: theme.base01
        radius: 8

        RowLayout {
          width: parent.width - 16
          height: parent.height - 16
          anchors.centerIn: parent
          
          spacing: 8

          Rectangle {
            height: parent.height
            width: height
            color: theme.base02
            radius: 8

            GoogleIcon {
              text: "art_track"
              color: theme.base00
              anchors.centerIn: parent
              font { pixelSize: 120 }
            }
            
            Image {
              id: img
              width: activePlayer == null ? 0 : parent.width - 8
              height: parent.height - 8
              anchors.centerIn: parent
              source: activePlayer.trackArtUrl
              fillMode: Image.PreserveAspectFit
            }

            ButtonArea {}
          }

          Rectangle {
            height: parent.height
            Layout.fillWidth: true
            color: 'transparent'
            
            ColumnLayout {
              anchors.fill: parent

              spacing: 8

              Rectangle {
                Layout.fillWidth: true
                height: parent.height/2
                color: theme.base02
                radius: 8
                
                ColumnLayout {
                  width: parent.width - 8
                  height: parent.height - 24
                  anchors.centerIn: parent

                  Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: 'transparent'

                    Row {
                      anchors.left: parent.left
                      width: parent.width
                      spacing: 8
                      GoogleIcon {
                        text: "Music_Note"
                        color: theme.accent
                      }
                      Label {
                        width: Math.min(parent.width - 32, implicitWidth)
                        text: activePlayer == null ? "Nothing" : activePlayer.trackTitle
                        color: theme.accent
                        font { pixelSize: 14 }
                      }
                    }
                  }

                  Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: 'transparent'
                    
                    Row {
                      anchors.left: parent.left
                      GoogleIcon {
                        text: "---------------------------------------"
                        color: theme.base01
                      }
                    }
                  }

                  Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: 'transparent'

                    Row {
                      width: parent.width
                      spacing: 4
                      GoogleIcon {
                        text: "artist"
                        color: theme.base05
                      }
                      Label {
                          id: trackArtist
                        width: Math.min(parent.width/2 - 32, implicitWidth)
                        opacity: 0.9
                        text: activePlayer == null ? "Nobody" : activePlayer.trackArtist
                        color: theme.base05
                        font { pixelSize: 12 }
                      }
                      GoogleIcon {
                        opacity: 0.7
                        text: "album"
                        color: theme.base05
                      }
                      Label {
                        width: Math.min(parent.width - trackArtist.width - 48, implicitWidth)
                        opacity: 0.6
                        text: activePlayer == null ? "Nowhere" : activePlayer.trackAlbum
                        color: theme.base05
                        font { pixelSize: 12 }
                      }
                    }
                  }
                }
                ButtonArea {}
              }

              Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: theme.base02
                radius: 8
              }
          }
        }
      }
    }
//      Rectangle {
//        anchors.left: dropdown.right
//        width: 8
