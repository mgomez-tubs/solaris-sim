import QtQuick 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls 2.15


/*
 *  This is the Default Layer that becomes active when the program is opened
 */


Item {
    id: layer_mainGUI
    objectName: "layer_mainGUI"
    anchors.fill: parent        // very important
    width: 800
    height: 600


    function enableInfoButton(){        // Enables the Info Button
        buttonInfo.visible = true
    }

    function disableInfoButton(){       // Disables the Info Button
        buttonInfo.visible = false
    }

    function deselectViews(){           // Deselects the FreeView checker in the View submenu (to allow going back to the initial view)
        rightMenu.freeViewChecked = false
    }

    ButtonForm {
        id: playButton
        width: 50
        height: 50
        buttonTextFontfamily: "SegoeUI"
        scale: 1
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        buttonTextFontpixelSize: 30
        buttonText: "\u23ef"

        MouseArea {
            id: playButton_mouseArea
            anchors.fill: parent

            // When the play button is pressed, toogle between Play/Paused states
            Connections {
                target: playButton_mouseArea
                function onClicked(){
                    tooglePlayPause_helper();
                }
            }
        }
    }

    ButtonForm {
        id: stopButton
        y: 540
        width: 35
        height: 35
        buttonTextFontfamily: "SegoeUI"
        buttonText: qsTr("⏹")
        anchors.leftMargin: 5
        buttonTextFontpixelSize: 20
        anchors.bottomMargin: 10
        anchors.left: playButton.right
        anchors.bottom: parent.bottom

        MouseArea {
            id: stopButton_mouseArea
            anchors.fill: parent

            Connections {
                target: stopButton_mouseArea
                // When this button button is pressed, stop the simulation
                function onClicked(){
                    resetSimulation_helper();
                }
            }
        }
    }

    ButtonForm {
        id: buttonSettings
        buttonText : "Settings"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10

        MouseArea {
            id: buttonSettings_mouseArea
            anchors.fill: parent
            // When this button is pressed, open the settings menu
            onClicked: {
                if(!rightMenu.visible){
                    rightMenu.visible = true;
                } else rightMenu.visible = false;
            }
        }
    }

    RightMenu {
        id: rightMenu
        x: 590
        y: 37
        height: 250
        visible: false
        opacity: 0.75
        anchors.right: parent.right
        anchors.rightMargin: 5
    }

    Dial {
        id: dial
        y: 530
        width: 80
        height: 60
        anchors.left: stopButton.right
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        wheelEnabled: true
        focusPolicy: Qt.NoFocus
        stepSize: 0.1
        to: 15
        value: 1
        onValueChanged: setSpeedMultiplier(value)
    }

    ButtonForm {
        id: buttonInfo
        visible: false
        MouseArea {
            id: buttonInfo_mouseArea1
            anchors.fill : parent
            onClicked: function(){     
                // Change currento layer to the Planet Layer
                view.layerHandler("PlanetGUI")
            }
        }
        anchors.bottomMargin: 2
        buttonText: "Info"
        anchors.rightMargin: 10
        anchors.bottom: buttonSettings.top
        anchors.right: parent.right
    }

    PresetSelectMenu {
        id: presetSelectMenu
        visible: false
        // Center the menu on screen
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
}

/*##^##
Designer {
    D{i:0;formeditorColor:"#000000";formeditorZoom:0.6600000262260437}
}
##^##*/
