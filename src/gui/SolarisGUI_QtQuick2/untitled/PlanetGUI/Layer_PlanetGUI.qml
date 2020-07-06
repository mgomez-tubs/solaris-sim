import QtQuick 2.0


Item {
    id: layer_planetGUI

    function fillPlanetInfo(name :String, numbers: String, info: String, exploration: String){
        planetName.text         = " ";      // no html on this one
        planetNumbers.text      = " ";      // hmm
        planetInfo              +=" ";      // rich text
        planetExploration.text  += " ";     // rich text
    }

    Text {
        id: planetName
        y: 8
        width: 407
        height: 88
        color: "#f3fc0b"
        text: qsTr("PlanetName")
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: 72
    }

    Text {
        id: planetNumbers
        y: 117
        width: 244
        height: 260
        color: "#f4f2f2"
        text: qsTr("Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data Data ")
        textFormat: Text.RichText
        anchors.left: parent.left
        anchors.leftMargin: 10
        wrapMode: Text.WordWrap
        font.pixelSize: 12
    }


    Text {
        id: planetInfo
        x: 446
        y: 135
        width: 186
        height: 103
        color: "#c21717"
        text: qsTr("<b>Information  </b></br>")
        textFormat: Text.RichText
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 12
    }

    Text {
        id: planetExploration
        x: 446
        y: 264
        width: 186
        height: 103
        color: "#d61414"
        text: qsTr("<b>Exploration</b></br>")
        textFormat: Text.RichText
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 12
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#000000";formeditorZoom:0.75;height:480;width:640}
D{i:1;anchors_x:8}D{i:2;anchors_x:16}
}
##^##*/
