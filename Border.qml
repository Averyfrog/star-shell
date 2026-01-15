pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Shapes
import Quickshell

Variants {
  model: Quickshell.screens
  
  Scope {
    id: scope
    required property ShellScreen modelData
    
    // My FNQRT Border Shape
    property color barsColor: theme.base00
    property real borderWidth: 16
    property real cornerRadius: 20
    
    PanelWindow {
      id: topBar
      implicitHeight: borderWidth
      color: barsColor
      anchors {
        left: true
        right: true
        top: settings.bar.side == 4
        bottom: settings.bar.side == 1
      }
    }

    PanelWindow {
      id: leftBar
      implicitWidth: borderWidth
      color: barsColor
      anchors {
        left: true
        top: true
        bottom: true
      }
      margins.bottom: -1
    }

    PanelWindow {
      id: rightBar
      implicitWidth: borderWidth
      color: barsColor
      anchors {
        right: true
        top: true
        bottom: true
      }
      margins.bottom: -1
    }
    
    PanelWindow {
      id: topLeftCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        top: true
        left: true
      }
      margins.left: 0
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: cornerRadius
          PathArc {
            x: cornerRadius
            y: 0
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: 0; y: 0 }
          PathLine { x: 0; y: cornerRadius }
        }
      }
    }
    
    // Top-right corner 
    PanelWindow {
      id: topRightCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        top: true
        right: true
      }
      margins.right: 0
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: 0
          PathArc {
            x: cornerRadius
            y: cornerRadius
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: cornerRadius; y: 0 }
          PathLine { x: 0; y: 0 }
        }
      }
    }
    
    // Bottom-left corner 
    PanelWindow {
      id: bottomLeftCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        bottom: true
        left: true
      }
      margins.left: 0
      margins.bottom: -1
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: cornerRadius
          startY: cornerRadius
          PathArc {
            x: 0
            y: 0
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
          PathLine { x: 0; y: cornerRadius }
          PathLine { x: cornerRadius; y: cornerRadius }
        }
      }
    }
    
    // Bottom-left corner -- quick note guys this controls the bottom right corner had to fix the margin issue)
    PanelWindow {
      id: bottomRightCorner
      screen: scope.modelData
      implicitWidth: cornerRadius
      implicitHeight: cornerRadius
      color: "transparent"
      exclusiveZone: 0
      anchors {
        bottom: true
        right: true
      }
      margins.right: 0
      margins.bottom: -1
      
      Shape {
        anchors.fill: parent
        preferredRendererType: Shape.CurveRenderer
        
        ShapePath {
          strokeWidth: 0
          fillColor: barsColor
          startX: 0
          startY: cornerRadius
          PathLine { x: cornerRadius; y: cornerRadius }
          PathLine { x: cornerRadius; y: 0 }
          PathArc {
            x: 0
            y: cornerRadius  
            radiusX: cornerRadius
            radiusY: cornerRadius
            direction: PathArc.Clockwise
          }
        }
      }
    }
  }
}
