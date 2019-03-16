import QtQuick 2.12
import QtQuick.Controls 2.5

Item {
    id: root
    property alias color: circle.color
    property alias backgroundColor: backgroundRectangle.color
    property color dimmedColor: color
    property alias borderRadius: backgroundRectangle.radius
    property bool checked: false

    signal trigger()

    Rectangle {
        id: backgroundRectangle
        anchors.fill: parent

        Rectangle {
            id: circle
            width: parent.height * 0.5
            height: width
            radius: width / 2
            y: parent.y + (parent.height - height) / 2
            x: parent.x + (parent.height - height) / 2
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {trigger(); root.checked = !root.checked}
        }
        states: [
        State {
                name: "Checked"; when: root.checked
                PropertyChanges {
                    target: circle
                    x: backgroundRectangle.x + backgroundRectangle.width - width * 1.5
                }
            },
            State {
                name: "Not Checked"; when: !root.checked
                PropertyChanges {
                    target: circle
                    x: backgroundRectangle.x + backgroundRectangle.x + (backgroundRectangle.height - height) / 2
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
