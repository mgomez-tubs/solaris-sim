import QtQuick 2.14

Item {
    id: element
    width: 100
    height: 30
    property alias mouseArea: mouseArea
    property alias buttonTextFontfamily: buttonText.font.family
    property alias buttonTextFontpixelSize: buttonText.font.pixelSize
    property alias buttonText: buttonText.text

    Rectangle {
        id: rectangle
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
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}
}
##^##*/

