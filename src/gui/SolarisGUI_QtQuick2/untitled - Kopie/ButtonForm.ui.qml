import QtQuick 2.15

Item {
    width: 100
    height: 100

    Rectangle {
        id: rectangle
        color: "#050c47"
        border.color: "#cd5614"
        anchors.fill: parent

        Text {
            id: element
            x: 39
            y: 43
            color: "#ffffff"
            text: qsTr("Text")
            font.pixelSize: 12
        }
    }
}

/*##^##
Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:143;anchors_y:208}
}
##^##*/

