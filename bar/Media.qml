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
          mediaDropdown.show = !mediaDropdown.show
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
    id: mediaDropdown
    anchor.item: root
    implicitWidth: 600
    implicitHeight: 200
    color: 'transparent'
    
    property bool show: false
    visible: true

    //RectangularShadow {
    //  anchors.fill: dropdown
    //  blur: 10
    //  radius: dropdown.radius
    //}

    StyledRect {
      id: dropdown
      anchors.centerIn: null
      implicitWidth: parent.width - 32
      height: parent.height
      x: 12
      y: mediaDropdown.show ? 0 : (settings.bar.side == 1 ? -height : height)
      Behavior on y {
        NumberAnimation {
          duration: 250
          easing.bezierCurve: settings.floating ? [0.38, 1.21, 0.22, 1, 1, 1] : [0.38, 1.0, 0.22, 1, 1, 1]
        }
      }
      color: theme.base00
      radius: 16

      topLeftRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      topRightRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      bottomLeftRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
      bottomRightRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius

      StyledRect {
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
    }
//      Rectangle {
//        anchors.left: dropdown.right
//        width: 8
//        height: 8
//      Shape {
//        preferredRendererType: Shape.CurveRenderer
//        
//        ShapePath {
//          strokeWidth: 0
//          fillColor: theme.base00
//          startX: 0
//          startY: 8
//          PathArc {
//            x: 8
//            y: 0
//            radiusX: 8
//            radiusY: 8
//            direction: PathArc.Clockwise
//          }
//          PathLine { x: 0; y: 0 }
//          PathLine { x: 0; y: 8 }
//        }
//}
//}
}
}
