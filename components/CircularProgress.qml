import QtQuick
import QtQuick.Shapes
import QtQuick.Controls
import Quickshell

  Shape {  
    id: shape
    preferredRendererType: Shape.CurveRenderer
    width: 16
    height: width
    anchors.centerIn: parent

    rotation: -90

    property int circleWidth: 4
    property double value: 0.25
    property color backgroundColor: theme.base00
    property color foregroundColor: theme.base0D

    Behavior on value {
      NumberAnimation {
        duration: 100
      }
    }

    ShapePath {
      strokeWidth: shape.circleWidth
      strokeColor: shape.backgroundColor
      fillColor: "transparent"

      PathAngleArc {
        centerX: shape.width / 2
        centerY: shape.width / 2
        radiusX: shape.width / 2
        radiusY: shape.width / 2
        sweepAngle: 360
      }
    }

    ShapePath {
      strokeWidth: shape.circleWidth
      strokeColor: shape.foregroundColor
      fillColor: "transparent"
      capStyle: ShapePath.RoundCap
      joinStyle: ShapePath.RoundJoin

      PathAngleArc {
        centerX: shape.width / 2
        centerY: shape.width / 2
        radiusX: shape.width / 2
        radiusY: shape.width / 2
        sweepAngle: shape.value * 360
      }
    }
  }
