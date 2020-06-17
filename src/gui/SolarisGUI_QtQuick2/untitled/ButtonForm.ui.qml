import QtQuick 2.14

Item {
    width: 100
    height: 30
    property alias buttonText: buttonText.text

    Rectangle {
        id: rectangle
        height: 35
        color: "#050c47"
        anchors.fill: parent
        border.color: "#cd5614"

        Text {
            id: buttonText
            x: 39
            y: 43
            width: 23
            height: 0
            color: "#ffffff"
            text: qsTr("dies ist ein button")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 12
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:1;anchors_height:200;anchors_width:200;anchors_x:143;anchors_y:208}
}
##^##*/

