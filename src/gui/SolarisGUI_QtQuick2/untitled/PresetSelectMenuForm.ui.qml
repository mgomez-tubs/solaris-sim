import QtQuick 2.4

Item {
    id: element
    width: 200
    height: 150

    Rectangle {
        id: rectangle1
        x: 180
        y: 207
        color: "#ffffff"
        anchors.fill: parent

    }

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 200
        height: 27
        color: "#adf696"

        Text {
            id: element1
            x: 66
            y: 0
            text: qsTr("Select Preset")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }
    }
}
