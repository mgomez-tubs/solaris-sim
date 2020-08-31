import QtQuick 2.0
import "qrc:/MainGUI" as GUIAssets

/*
 *  This is the Layer that becomes active when the Info button is clicked
 *
 */

Item {
    id: layer_planetGUI

    // Fill the Information to be displayed with the Information stored in the current planet
    function fillPlanetInfo(name :String, numbers: String, info: String, exploration: String){
        planetName.text         = " ";      // no html on this one
        planetInfo.text      = " ";      // hmm
        planetInfo              +=" ";      // rich text
        planetExploration.text  += " ";     // rich text
    }

    Text {      // The displayed text
        id: planetInfo
        y: 237
        width: 270
        height: 223
        color: "#f4f2f2"
        text: view.currentPlanet.planetInfoString
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        font.family: "Consolas"
        textFormat: Text.RichText
        anchors.left: parent.left
        anchors.leftMargin: 20
        wrapMode: Text.WordWrap
        font.pixelSize: 11
    }

    GUIAssets.ButtonForm{       // Button to go back
        buttonText: "Go Back"
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        MouseArea {
            id: goBackButton_mouseArea
            anchors.fill: parent
            // When pressing the Back button change the current layer to the Main GUI layer
            onClicked: function(){
                view.layerHandler("MainGUI");
                view.enableInfoButton()
            }
        }

    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorColor:"#000000";formeditorZoom:0.75;height:480;width:640}
D{i:1;anchors_height:223;anchors_x:8;anchors_y:237}
}
##^##*/
