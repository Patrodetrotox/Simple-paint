import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root
    visible: true
    height: 900
    width: 450


    Canvas {

        id: canvas
        property string lineColor: "black"
        property var lines: []
        property real lWidth: 5
        anchors.fill: parent

        function addLine(color, width, points) {
            var line = {
                "points": points,
                "color": color,
                "width": width
            };
            lines.push(line);
            canvas.requestPaint();
        }

        function removeColor(color) {
            lines = lines.filter(function (line) {
                return line.color !== color
            })

            var ctx = canvas.getContext("2d");
            ctx.clearRect(0, 0, width, height)
            canvas.requestPaint();
        }


        MouseArea {
            anchors.fill: parent

            onPressed: {
                var points = [];
                var point = {
                    "x": mouseX,
                    "y": mouseY
                };
                points.push(point);
                canvas.addLine(canvas.lineColor, canvas.lWidth, points);
            }

            onPositionChanged: {
                var point = {
                    "x": mouseX,
                    "y": mouseY
                };
                canvas.lines[canvas.lines.length - 1].points.push(point);
                canvas.requestPaint();
            }
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

        Connections {
            target: plus
            onClicked: canvas.lWidth++
        }

        Connections {
            target: minus
            onClicked: canvas.lWidth--
        }

        Connections {
            target: x
            onClicked: canvas.removeColor(canvas.lineColor)
        }

        Connections {
            target: blue
            onTriggered: canvas.lineColor = "blue"
        }

        Connections {
            target: black
            onTriggered: canvas.lineColor = "black"
        }

        Connections {
            target: red
            onTriggered: canvas.lineColor = "red"
        }

        Connections {
            target: green
            onTriggered: canvas.lineColor = "green"
        }

        Connections {
            target: yellow
            onTriggered: canvas.lineColor = "yellow"
        }
    }

    Row {
        id: switches
        x: spacing
        y: parent.height - height - 10
        width: parent.width
        height: red.height
        spacing: 5

        Switch {
            id: red
            color: "red"
            backgroundColor: "light grey"
            dimmedColor: "dark grey"
            borderRadius: height / 2
            width: (parent.width - 6 *parent.spacing) / 5
            height: width / 2
            states: [
                State {
                    when: canvas.lineColor === "red"
                    PropertyChanges {
                        target: red
                        checked: true
                    }
                },
                State {
                    when: canvas.lineColor !== "red"
                    PropertyChanges {
                        target: red
                        checked: false
                    }
                }
            ]
        }

        Switch {
            id: green
            color: "green"
            backgroundColor: "light grey"
            dimmedColor: "dark grey"
            borderRadius: height / 2
            width: (parent.width - 6 *parent.spacing) / 5
            height: width / 2
            states: [
                State {
                    when: canvas.lineColor === "green"
                    PropertyChanges {
                        target: green
                        checked: true
                    }
                },
                State {
                    when: canvas.lineColor !== "green"
                    PropertyChanges {
                        target: green
                        checked: false
                    }
                }
            ]
        }


        Switch {
            id: blue
            color: "blue"
            backgroundColor: "light grey"
            dimmedColor: "dark grey"
            borderRadius: height / 2
            width: (parent.width - 6 *parent.spacing) / 5
            height: width / 2
            states: [
                State {
                    when: canvas.lineColor === "blue"
                    PropertyChanges {
                        target: blue
                        checked: true
                    }
                },
                State {
                    when: canvas.lineColor !== "blue"
                    PropertyChanges {
                        target: blue
                        checked: false
                    }
                }
            ]
        }

        Switch {
            id: yellow
            color: "yellow"
            backgroundColor: "light grey"
            dimmedColor: "dark grey"
            borderRadius: height / 2
            width: (parent.width - 6 *parent.spacing) / 5
            height: width / 2
            states: [
                State {
                    when: canvas.lineColor === "yellow"
                    PropertyChanges {
                        target: yellow
                        checked: true
                    }
                },
                State {
                    when: canvas.lineColor !== "yellow"
                    PropertyChanges {
                        target: yellow
                        checked: false
                    }
                }
            ]
        }

        Switch {
            id: black
            color: "black"
            backgroundColor: "light grey"
            dimmedColor: "dark grey"
            borderRadius: height / 2
            width: (parent.width - 6 *parent.spacing) / 5
            height: width / 2
            states: [
                State {
                    when: canvas.lineColor === "black"
                    PropertyChanges {
                        target: black
                        checked: true
                    }
                },
                State {
                    when: canvas.lineColor !== "black"
                    PropertyChanges {
                        target: black
                        checked: false
                    }
                }
            ]
        }
    }

    Column {
        x: parent.width - x.width - 5
        y: (parent.height - height - 10) / 2  //10 from switches
        height: parent.height / 2 + 4 * spacing
        spacing: 5
        width: parent.width / 7



        Button {
            id: x
            text: "X"
            height: parent.height / 6
            width: height
            textFont {pointSize: height / 3}
            textColor: "Black"
            color: "light Grey"
            pressedColor: "Grey"
            dimmedColor: "Dark grey"
            padding: height / 3
        }

        Button {
            id: plus
            text: "+"
            height: parent.height / 6
            width: height
            textFont {pointSize: height / 3}
            textColor: "Black"
            color: "light Grey"
            pressedColor: "Grey"
            dimmedColor: "Dark grey"
            padding: height / 3
        }

        Button {
            id: minus
            text: "-"
            height: parent.height / 6
            width: height
            textFont {pointSize: height / 3}
            textColor: "Black"
            color: "light Grey"
            pressedColor: "Grey"
            dimmedColor: "Dark grey"
            padding: height / 3
        }
    }
}
