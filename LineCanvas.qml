import QtQuick 2.0

Canvas {
    id: canvas

    property string lineColor: "black"
    property var lines: []
    property real lWidth: 5

    function addLine(color, width, points) {
        var line = {
            "points": points,
            "color": color,
            "width": width
        };
        lines.push(line);
        canvas.requestPaint();
        return line;
    }

    function removeColor(color) {
        lines = lines.filter(function (line) {
            return line.color !== color
        })

        var ctx = canvas.getContext("2d");
        ctx.clearRect(0, 0, width, height)
        canvas.requestPaint();
    }

    onPaint: {
        var ctx = canvas.getContext("2d");
        canvas.lines.forEach(function(line) {
            ctx.strokeStyle = line.color;
            ctx.lineWidth = line.width;
            ctx.beginPath();
            line.points.forEach(function(point, iPoint) {
                if(iPoint === 0) {
                    ctx.moveTo(point.x, point.y);
                } else {
                    ctx.lineTo(point.x, point.y);
                }
            })
            ctx.stroke();
        })
    }
}
