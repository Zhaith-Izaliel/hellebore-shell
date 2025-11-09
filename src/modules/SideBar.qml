pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import Quickshell

import qs.components.containers

LayerWindow {
    id: root
    name: "main"

    property int size: 5
    property real rounding: 40

    anchors {
        bottom: true
        top: true
        left: true
        right: true
    }

    mask: Region {
        item: clickMask
        intersection: Intersection.Xor
    }

    Rectangle {
        id: clickMask
        anchors.centerIn: parent
        width: parent.width - root.size
        height: parent.height - root.size
        color: "transparent"
    }

    Shape {
        anchors.fill: parent

        ShapePath {
            id: path
            strokeWidth: 3
            strokeColor: "red"
            fillColor: "#FFFFFF"

            startX: root.rounding
            startY: 0

            // pathHints: ShapePath.PathConvex

            PathLine {
                relativeX: root.width - root.rounding * 2
                relativeY: 0
            }
            PathArc {
                relativeX: root.rounding
                relativeY: root.rounding

                radiusX: root.rounding
                radiusY: root.rounding
            }
            PathLine {
                relativeX: 0
                relativeY: -root.rounding
            }
            PathLine {
                relativeX: -root.width
                relativeY: 0
            }
            PathLine {
                relativeX: 0
                relativeY: root.rounding
            }
            PathArc {
                relativeX: root.rounding
                relativeY: -root.rounding

                radiusX: root.rounding
                radiusY: root.rounding
            }
        }
    }
}
