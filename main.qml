import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root
    visible: true
    height: 900
    width: 450

    LineCanvas {
        id: drawedCanvas
        anchors.fill: parent
    }

    LineCanvas {

        id: usedCanvas
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent

            onPressed: {
                var points = [];
                var point = {
                    "x": mouseX,
                    "y": mouseY
                };
                points.push(point);
                usedCanvas.addLine(usedCanvas.lineColor, usedCanvas.lWidth, points);
            }

            onPositionChanged: {
                var point = {
                    "x": mouseX,
                    "y": mouseY
                };
                usedCanvas.lines[0].points.push(point);
                usedCanvas.requestPaint();
            }

            onReleased: {
                drawedCanvas.lines.push(usedCanvas.lines.pop());
                var ctx = usedCanvas.getContext("2d");
                ctx.clearRect(0, 0, width, height)
                usedCanvas.requestPaint();
                drawedCanvas.requestPaint();
            }
        }

        Connections {
            target: plus
            onClicked: usedCanvas.lWidth++
        }

        Connections {
            target: minus
            onClicked: usedCanvas.lWidth--
        }

        Connections {
            target: x
            onClicked: drawedCanvas.removeColor(usedCanvas.lineColor)
        }

        Connections {
            target: blue
            onTriggered: usedCanvas.lineColor = "blue"
        }

        Connections {
            target: black
            onTriggered: usedCanvas.lineColor = "black"
        }

        Connections {
            target: red
            onTriggered: usedCanvas.lineColor = "red"
        }

        Connections {
            target: green
            onTriggered: usedCanvas.lineColor = "green"
        }

        Connections {
            target: yellow
            onTriggered: usedCanvas.lineColor = "yellow"
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
                    when: usedCanvas.lineColor === "red"
                    PropertyChanges {
                        target: red
                        checked: true
                    }
                },
                State {
                    when: usedCanvas.lineColor !== "red"
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
                    when: usedCanvas.lineColor === "green"
                    PropertyChanges {
                        target: green
                        checked: true
                    }
                },
                State {
                    when: usedCanvas.lineColor !== "green"
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
                    when: usedCanvas.lineColor === "blue"
                    PropertyChanges {
                        target: blue
                        checked: true
                    }
                },
                State {
                    when: usedCanvas.lineColor !== "blue"
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
                    when: usedCanvas.lineColor === "yellow"
                    PropertyChanges {
                        target: yellow
                        checked: true
                    }
                },
                State {
                    when: usedCanvas.lineColor !== "yellow"
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
                    when: usedCanvas.lineColor === "black"
                    PropertyChanges {
                        target: black
                        checked: true
                    }
                },
                State {
                    when: usedCanvas.lineColor !== "black"
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
