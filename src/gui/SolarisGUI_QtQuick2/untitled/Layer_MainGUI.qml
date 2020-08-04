import QtQuick 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent        // very important
    width: 800
    height: 600
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

            Connections {
                target: playButton_mouseArea
                onClicked: function(){
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
                onClicked: function(){
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
        height: 450
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
        to: 10
        value: 1
        onValueChanged: setSpeedMultiplier(value)
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.009999999776482582}
}
##^##*/
