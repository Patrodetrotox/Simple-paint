import QtQuick 2.0
import QtQuick.Controls 2.5
import "painter.js"

Item {
    property var lines: []

    Canvas {
        id: canvas
        anchors.fill: parent

//        function addLine(color color, real width, point[] points) {

//        }

//        function removeColor(color color) {

//        }

        onPaint: {
            var ctx = getContext('2d');
            ctx.clear(0, 0, width, height);
            Painter.paintLines(ctx, lines);
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onPressed: lines.push({
            stroke: "#000000", path: "M"+mouseX+" "+mouseY
        })
        onPositionChanged: {
            lines[lines.length - 1].path += " "+mouseX+" "+mouseY;
            canvas.requestPaint();
        }
    }
}
