import QtQuick 2.14
import QtQuick.Controls 2.5

Item {
    id: menu
    width: 200
    height: 25
    property real maxheight: 200
    property alias maxheight : menu.maxheight
    clip: false
    states: [
        State {
            name: "min"
            PropertyChanges {
                target: menu
                height: 25
            }
        },
        State {
            name: "max"
            PropertyChanges {
                target: menu
                height: menu.maxheight
            }
        }
    ]
    Behavior on height {

        PropertyAnimation {
            easing.type: Easing.InOutQuad
        }
    }
    property alias menuHeight: menu.height
    property alias rowHeight: row.height
    property alias menuClip: menu.clip
    property alias elementText: element.text

    property bool maximized: false

    Rectangle {
        id: lowerRec
        x: 0
        width: 200
        height: 200
        color: "#bc1818"
        anchors.top: upperRec.bottom
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true

        Row {
            id: row
            anchors.fill: parent
        }
    }
    Rectangle {
        id: upperRec
        color: "#050c47"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0
        property bool minimized: true
        x: 100
        width: 200
        height: 25

        Text {
            id: element
            y: 8
            color: "#ffffff"
            text: qsTr("Text")
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }

        MouseArea {
            id: mouseArea
            clip: false
            anchors.fill: parent
            z: 10
            scale: 1
            Connections {
                function onClicked() {
                    if (maximized == false) {
                        menu.state = "max"
                    } else {
                        menu.state = "min"
                    }
                    maximized = !maximized
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;height:25;width:200}
}
##^##*/
