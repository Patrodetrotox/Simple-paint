import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    id: root
    property alias color: circle.color
    property alias backgroundColor: backgroundRectangle.color
    property color dimmedColor: color
    property alias borderRadius: backgroundRectangle.radius
    property bool checked: false

    signal triggered()

    function trigger() {
        if(!root.checked) {
            triggered()
        }
    }

    Rectangle {
        id: backgroundRectangle
        anchors.fill: parent

        Rectangle {
            id: circle
            width: parent.height
            height: width
            radius: width / 2
            y: parent.y
            x: parent.x + parent.width - width
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {root.trigger()}
        }
        states: [
        State {
                name: "Checked"; when: root.checked
                PropertyChanges {
                    target: circle
                    x: backgroundRectangle.x + backgroundRectangle.width - width
                }
            },
            State {
                name: "Not Checked"; when: !root.checked
                PropertyChanges {
                    target: circle
                    x: backgroundRectangle.x

                }
            }

        ]
        transitions: [
            Transition {
                from: "Checked"
                reversible: true
                PropertyAnimation {
                    duration: 200
                    properties: "x,y"
                }
            }
        ]
    }
}
