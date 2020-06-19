import QtQuick 2.4

Item {
    width: 400
    height: 400
    property alias rectangle1Height: rectangle1.height
    visible: true

    Rectangle {
        id: rectangle
        x: 100
        y: 103
        width: 200
        height: 25
        color: "#3e0d88"
        z: 1

        Connections {
            target: rectangle
            onClicked: print("clicked")
        }
    }

    Rectangle {
        id: rectangle1
        x: 100
        y: 103
        width: 200
        height: 200
        color: "#ffffff"
        visible: true
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}
}
##^##*/
