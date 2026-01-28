import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
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
      radius: settings.media.design == 2 ? 160 : 8
      color: settings.media.design == 2 ? theme.accent : theme.base02
      
      Rectangle {
        anchors.centerIn: parent
        height: parent.height - 8
        width: height
        radius: 160
        color: '#242629'
      }

      GoogleIcon {
        text: "album"
        color: '#363841'
        anchors.centerIn: parent
        font { pixelSize: 120 }
      }
      
      ClippingWrapperRectangle {
        radius: settings.media.design == 2 ? 160 : 8
        width: activePlayer == null ? 0 : (settings.media.design == 2 ? parent.width - 32 : parent.width - 8)
        height: width
        anchors.centerIn: parent
        Image {
          id: img
          width: activePlayer == null ? 0 : parent.width - 8
          height: parent.height - 8
          property double spin: 0
          rotation: settings.media.design == 1 ? 0 : spin
          anchors.centerIn: parent
          source: activePlayer.trackArtUrl
          fillMode: Image.PreserveAspectFit
          FrameAnimation {
            running: activePlayer.isPlaying && settings.media.design == 2
            onTriggered: {
              img.spin += 0.1
            }
          }
        }
      }
      
      Rectangle {
        anchors.centerIn: parent
        height: parent.height - 128 - 8
        width: height
        radius: 160
        color: '#363841'
        opacity: settings.media.design == 2
      }

      Rectangle {
        anchors.centerIn: parent
        height: parent.height - 128 - 16
        width: height
        radius: 160
        color: theme.base01
        opacity: settings.media.design == 2
      }


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
                  width: Math.min(parent.width/1.2 - 32, implicitWidth)
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
          color: theme.base00
          radius: 8
          StyledSlider {
            id: control
            anchors {
              top: parent.top
              topMargin: 16
              horizontalCenter: parent.horizontalCenter
            }
            width: parent.width - 64
            height: 8

            value: pressed ? null : activePlayer.position
            to: activePlayer.length

            FrameAnimation {
              // only emit the signal when the position is actually changing.
              running: activePlayer.playbackState == MprisPlaybackState.Playing
              // emit the positionChanged signal every frame.
              onTriggered: activePlayer.positionChanged()
            }
          }
          RowLayout {
            anchors {
              horizontalCenter: parent.horizontalCenter
              bottom: parent.bottom
              bottomMargin: 8
            }
            Rectangle {
              height: 24
              width: 60
              color: 'transparent'
              Label {
                anchors.centerIn: parent
                text: sToTime(activePlayer.position.toFixed(0))
                opacity: 0.7

                function sToTime(s) {
                  var secs = s % 60;
                  s = (s - secs) / 60;
                  var mins = s % 60;
                  var hrs = (s - mins) / 60;

                  return ("0" + mins).slice(-2) + ":" + ("0" + secs).slice(-2);
                }
              }
            }
            StyledRect {
              anchors.centerIn: null
              color: theme.base02
              width: 32
              height: 24

              bottomRightRadius: 4
              topRightRadius: 4

              ButtonArea {
                onClicked: activePlayer.previous()
              }
              GoogleIcon {
                anchors.centerIn: parent
                text: 'skip_previous'
                color: theme.accent
              }
            }
            StyledRect {
              anchors.centerIn: null
              color: theme.base02
              width: 32
              height: 24

              radius: 4

              ButtonArea {
                onClicked: activePlayer.seek(-10)
              }
              GoogleIcon {
                anchors.centerIn: parent
                text: 'replay_10'
                color: theme.accent
              }
            }
            StyledRect {
              anchors.centerIn: null
              color: theme.accent
              width: 32
              height: 32

              ButtonArea {
                defColor: theme.accent
                onClicked: activePlayer.togglePlaying()
              }
              GoogleIcon {
                anchors.centerIn: parent
                text: activePlayer != null && activePlayer.isPlaying ? "pause_circle" : "play_circle"
                color: theme.base00
                font.pixelSize: 20
              }
            }
            StyledRect {
              anchors.centerIn: null
              color: theme.base02
              width: 32
              height: 24

              radius: 4

              ButtonArea {
                onClicked: activePlayer.seek(10)
              }
              GoogleIcon {
                anchors.centerIn: parent
                text: 'forward_10'
                color: theme.accent
              }
            }
            StyledRect {
              anchors.centerIn: null
              color: theme.base02
              width: 32
              height: 24

              bottomLeftRadius: 4
              topLeftRadius: 4

              ButtonArea {
                onClicked: activePlayer.next()
              }
              GoogleIcon {
                anchors.centerIn: parent
                text: 'skip_next'
                color: theme.accent
              }
            }
            Rectangle {
              height: 24
              width: 60
              color: 'transparent'
              Label {
                anchors.centerIn: parent
                text: sToTime(activePlayer.length.toFixed(0))
                opacity: 0.7

                function sToTime(s) {
                  var secs = s % 60;
                  s = (s - secs) / 60;
                  var mins = s % 60;
                  var hrs = (s - mins) / 60;

                  return ("0" + mins).slice(-2) + ":" + ("0" + secs).slice(-2);
                }
              }
            }
          }
        }
      }
    }
  }
}
//      Rectangle {
//        anchors.left: dropdown.right
//        width: 8
