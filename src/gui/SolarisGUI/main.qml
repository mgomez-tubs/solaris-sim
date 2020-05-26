import QtQuick 2.6
import io.qt.examples.backend 1.0


Rectangle {
    width:  100
    height: 100
    color: "blue"

    BackEnd{
        id: backend
    }

    Text {
        anchors.centerIn: parent
        text: backend.userName
    }


}
