import Quickshell
import Quickshell.Widgets
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import '../components'

ClippingWrapperRectangle {
  color: 'transparent'
  anchors.centerIn: parent
  height: parent.height - 32
  width: parent.width - 32
  anchors.top: parent.top
  anchors.topMargin: 16
  property list<string> themes
  radius: 16
Flickable {
  id: root
  anchors.centerIn: parent
  width: parent.width
  height: parent.height - 16
  contentHeight: themesList.height 
  clip: true
  maximumFlickVelocity: 200
  flickDeceleration: 0.0001


  ColumnLayout {
    id: themesList
    //anchors.fill: parent
    anchors.centerIn: parent
    width: parent.width

    Process {
      id: themeVariants
      property string info
      running: true
      command: [ "constellate", "list" ]
      stdout: StdioCollector {
        onStreamFinished: {
          themes = this.text.split('\n')
          themes.pop()
          themes.sort()
        }
      }
    }
            
    Repeater {
      model: ScriptModel {
        values: themes
      }
      delegate: StyledRect {
        id: buton
        anchors.centerIn: null
        edgeGap: 16
        height: 48
        width: parent.width
        Layout.alignment: Qt.AlignHCenter

        Process {
          running: true
          command: [ "constellate", "var", modelData, "base02" ]
          stdout: StdioCollector {
            onStreamFinished: {
              buton.color = '#' + this.text.trim()
              butonArea.defColor = '#' + this.text.trim()
            }
          }
        }

        RowLayout {
          anchors.centerIn: parent
          width: parent.width-8
          height: parent.height-8
          StyledRect {
            color: 'transparent'
            anchors.centerIn: null
            width: parent.width
            Label {
              id: name
              width: Math.min(parent.width - 16, implicitWidth)
              anchors.centerIn: parent
              Process {
                running: true
                command: [ "constellate", "var", modelData, "text" ]
                stdout: StdioCollector {
                  onStreamFinished: {
                    name.color = '#' + this.text.trim()
                  }
                }
              }
              Process {
                running: true
                command: [ "constellate", "var", modelData, "name" ]
                stdout: StdioCollector {
                  onStreamFinished: {
                    name.text = this.text.trim()
                  }
                }
              }
            }
          }
        }
        ButtonArea {
          id: butonArea
          onClicked: {
            themeCommand.running = true
            popup.toggle()
          }
          Process {
            running: true
            command: [ "constellate", "var", modelData, "base03" ]
            stdout: StdioCollector {
              onStreamFinished: {
                butonArea.hoverColor = '#' + this.text.trim()
              }
            }
          }
        }
        Process {
          id: themeCommand
          running: false
          command: [ "constellate", "theme", modelData ]
        }
      }
    }
  }
}
}
