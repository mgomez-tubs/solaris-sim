import QtQuick 2.14

Item {
    id: fpsDisplayControl
    width: 70
    height: 20
    property alias elementText: element.text

    Rectangle {
        id: rectangle
        width: 400
        color: "#2d2323"
        anchors.fill: parent

        Text {
            id: element
            x: 100
            y: 93
            width: 167
            height: 84
            color: "#b3a5a5"
            text: qsTr("fps")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: "Consolas"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 15
        }
    }
}
