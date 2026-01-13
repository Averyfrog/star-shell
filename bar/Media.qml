import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Mpris 
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Shapes

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

    Rectangle {
      id: song

      height: root.height - 8
      width: musicRow.width + 16
      //anchors.centerIn: parent
      anchors.verticalCenter: parent.verticalCenter

      color: theme.base02
      radius: 16
      topRightRadius: 8
      bottomRightRadius: 8

      MouseArea {
        anchors.fill: parent
        onClicked: mediaDropdown.visible = !mediaDropdown.visible
        cursorShape: Qt.PointingHandCursor
      }

      Row {
        id: musicRow
        anchors.centerIn: parent
        spacing: 4

        Text {
          width: Math.min(200, implicitWidth)
          elide: Text.ElideRight
          anchors.verticalCenter: parent.verticalCenter
          text: activePlayer == null ? "Nothing" : activePlayer.trackTitle
          font {
            bold: true
          }
          color: theme.accent
        }

        Text {
          anchors.verticalCenter: parent.verticalCenter
          font {
            pixelSize: 14;
            bold: true
            family: "Material Symbols Rounded"
            weight: 700
            styleName: "Normal"
          }

          elide: Text.ElideRight
          color: theme.accent
          text: "music_note"
        }

        Text {
          width: Math.min(160, implicitWidth)
          elide: Text.ElideRight
          anchors.verticalCenter: parent.verticalCenter
          color: theme.accent
          opacity: 0.7
          text: activePlayer == null ? "Nobody" : activePlayer.trackArtist
          font {
            bold: true
          }
        }
      }
    }

    Rectangle {
      height: root.height - 8
      width: height
      anchors.verticalCenter: parent.verticalCenter

      color: theme.base02
      radius: 16
      topLeftRadius: 8
      bottomLeftRadius: 8
      
      MouseArea {
        anchors.fill: parent
        onClicked: activePlayer.togglePlaying()
        cursorShape: Qt.PointingHandCursor
      }

      Text {
        anchors.centerIn: parent
        font {
          pixelSize: 14;
          bold: true
          family: "Material Symbols Rounded"
          weight: 700
          styleName: "Normal"
        }

        color: activePlayer == null ? theme.base01 : theme.accent
        text: activePlayer != null && activePlayer.isPlaying ? "pause" : "play_arrow"
      }
    }
  }

  PopupWindow {
    id: mediaDropdown
    anchor {
      item: root
      rect.x: root.width/2 - width/2
      rect.y: settings.bar.side == 1 ? (settings.floating ? 52 : 33) : (settings.floating ? -216 : -194)
    }
    implicitWidth: 600
    implicitHeight: 200
    color: 'transparent'

    //RectangularShadow {
    //  anchors.fill: dropdown
    //  blur: 10
    //  radius: dropdown.radius
    //}

    Rectangle {
      id: dropdown
      anchors.centerIn: parent
      width: parent.width - 20
      height: parent.height - 10
      color: theme.base00
      radius: 16

      topLeftRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      topRightRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
      bottomLeftRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
      bottomRightRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius

      Rectangle {
        width: parent.width - 16
        height: parent.height - 16
        color: theme.base01
        anchors.centerIn: parent
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

            Text {
              anchors.centerIn: parent
              font {
                pixelSize: 120;
                bold: true
                family: "Material Symbols Rounded"
                weight: 700
                styleName: "Normal"
              }

              color: theme.base00
              text: "art_track"
            }
            
            Image {
              id: img
              width: activePlayer == null ? 0 : parent.width - 8
              height: parent.height - 8
              anchors.centerIn: parent
              source: activePlayer.trackArtUrl
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
                      spacing: 8
                      Text {
                        anchors.verticalCenter: parent.verticalCenter
                        font {
                          pixelSize: 16;
                          bold: true
                          family: "Material Symbols Rounded"
                          weight: 700
                          styleName: "Normal"
                        }

                        color: theme.accent
                        text: "Music_Note"
                      }
                      Text {
                        width: Math.min(parent.width - 32, implicitWidth)
                        elide: Text.ElideRight
                        anchors.verticalCenter: parent.verticalCenter
                        color: theme.accent
                        opacity: 1
                        text: activePlayer == null ? "Nothing" : activePlayer.trackTitle
                        font {
                          pixelSize: 14
                          bold: true
                        }
                      }
                    }
                  }

                  Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: 'transparent'
                    
                    Row {
                      anchors.left: parent.left
                      Text {
                        anchors.verticalCenter: parent.verticalCenter
                        font {
                          pixelSize: 14;
                          bold: true
                          family: "Material Symbols Rounded"
                          weight: 700
                          styleName: "Normal"
                        }

                        color: theme.base01
                        text: "--------------------------------------------"
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
                      Text {
                        anchors.verticalCenter: parent.verticalCenter
                        font {
                          pixelSize: 15;
                          bold: true
                          family: "Material Symbols Rounded"
                          weight: 700
                          styleName: "Normal"
                        }

                        color: theme.base05
                        text: "artist"
                      }
                      Text {
                        id: trackArtist
                        width: Math.min(parent.width/2 - 32, implicitWidth)
                        elide: Text.ElideRight
                        color: theme.base05
                        opacity: 0.9
                        text: activePlayer == null ? "Nobody" : activePlayer.trackArtist
                        font {
                          pixelSize: 12
                          bold: true
                        }
                      }
                      Text {
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: 0.7
                        font {
                          pixelSize: 10
                          bold: true
                          family: "Material Symbols Rounded"
                          weight: 700
                          styleName: "Normal"
                        }

                        color: theme.base05
                        text: "album"
                      }
                      Text {
                        width: Math.min(parent.width - trackArtist.width - 48, implicitWidth)
                        elide: Text.ElideRight
                        color: theme.base05
                        opacity: 0.6
                        text: activePlayer == null ? "Nowhere" : activePlayer.trackAlbum
                        font {
                          pixelSize: 12
                          bold: true
                        }
                      }
                    }
                  }
                }
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
