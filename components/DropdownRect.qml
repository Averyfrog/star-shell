import Quickshell
import QtQuick
import QtQuick.Shapes

StyledRect {
  id: dropdown
  anchors.centerIn: null
  width: parent.width - 32
  height: parent.height
  x: 16
  y: popup.show ? 0 : (settings.bar.side == 1 ? -height : height)
  Behavior on y {
    NumberAnimation {
      duration: 250 / settings.animationSpeed
      easing.bezierCurve: settings.floating ? [0.38, 1.21, 0.22, 1, 1, 1] : [0.38, 1.0, 0.22, 1, 1, 1]
    }
  }
  Behavior on width {
    NumberAnimation {
      duration: (250 * height/200) / settings.animationSpeed
      easing.bezierCurve: [0.38, 1.0, 0.22, 1, 1, 1]
    }
  }
  color: theme.base00
  radius: 16

  topLeftRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
  topRightRadius: !settings.floating ? (settings.bar.side != 1 ? radius : 0) : radius
  bottomLeftRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius
  bottomRightRadius: !settings.floating ? (settings.bar.side != 4 ? radius : 0) : radius

  Shape {
    anchors.left: parent.right
    anchors.top: parent.top
    anchors.topMargin: Math.min(1 - dropdown.y, parent.height - 32)
    preferredRendererType: Shape.CurveRenderer
    
    opacity: settings.floating == false && settings.bar.side == 1
    
    ShapePath {
      strokeWidth: 0
      fillColor: theme.base00
      startX: 0
      startY: 20
      PathArc {
        x: 20
        y: 0
        radiusX: 20
        radiusY: 20
        direction: PathArc.Clockwise
      }
      PathLine { x: 20; y: 0 }
      PathLine { x: 0; y: 0 }
    }
  }
  Shape {
    anchors.right: parent.left
    anchors.top: parent.top
    anchors.topMargin: Math.min(1 - dropdown.y, parent.height - 32)
    preferredRendererType: Shape.CurveRenderer
    
    opacity: settings.floating == false && settings.bar.side == 1
    
    ShapePath {
      strokeWidth: 0
      fillColor: theme.base00
      startX: 0
      startY: 0
      PathArc {
        x: 20
        y: 20
        radiusX: 20
        radiusY: 20
        direction: PathArc.Clockwise
      }
      PathLine { x: 20; y: 0 }
      PathLine { x: 0; y: 0 }
    }
  }
  Shape {
    anchors.left: parent.right
    anchors.bottom: parent.bottom
    anchors.bottomMargin: Math.min(dropdown.y, parent.height - 32)
    preferredRendererType: Shape.CurveRenderer
    
    ShapePath {
      strokeWidth: 0
      fillColor: theme.base00
      startX: 20
      startY: 20
      PathArc {
        x: 0
        y: 0
        radiusX: 20
        radiusY: 20
        direction: PathArc.Clockwise
      }
      PathLine { x: 0; y: 20 }
      PathLine { x: 20; y: 20 }
    }
  }
  Shape {
    anchors.right: parent.left
    anchors.bottom: parent.bottom
    anchors.bottomMargin: Math.min(dropdown.y, parent.height - 32)
    preferredRendererType: Shape.CurveRenderer
    
    ShapePath {
      strokeWidth: 0
      fillColor: theme.base00
      startX: 0
      startY: 20
      PathLine { x: 20; y: 20 }
      PathLine { x: 20; y: 0 }
      PathArc {
        x: 0
        y: 20  
        radiusX: 20
        radiusY: 20
        direction: PathArc.Clockwise
      }
    }
  }
}
