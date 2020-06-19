import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick3D 1.15
import QtQuick3D.Effects 1.15
import QtQuick.Controls 2.12
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 600
    title: qsTr("Solaris")

    // FPS counter
    property int fps: 0

    // Signals
    signal mainWclosed()
    signal tooglePlayPause()
    signal resetSimulation();

    // Signal Helpers
    function tooglePlayPause_helper(){
        tooglePlayPause()
    }

    function resetSimulation_helper(){
        resetSimulation();
    }

    onFpsChanged: {
        fpsCounter.elementText=window.fps + " fps"
    }

    onClosing:  {
        mainWclosed()
    }

    View3D {
        id: view
        anchors.fill: parent

        //! [environment]

        environment: SceneEnvironment{
            clearColor: "black"
            effects: HDRBloomTonemap{
                bloomThreshold: .8
                exposure: 0
            }

            // Qt 2.14
            //multisampleAAMode: "SceneEnvironment.X4"

            // Qt 2.15
            antialiasingMode: "MSAA"            // Multisample AA
            antialiasingQuality: "High"         // High quality

            backgroundMode: SceneEnvironment.Color
        }
        //! [environment]

        PerspectiveCamera {     // no rendering w/o PerspectiveCamera!!
            id: camera
            position: Qt.vector3d(0, 0, 1000)
            eulerRotation: Qt.vector3d(0, 0, 0)        // arguments are in degrees, positive numbers rotate clockwise

        }

        WasdController {
            controlledObject: camera
        }

        // functions
        function getPlanetList(){
            var planets = ["merkur","venus","erde","mars","jupiter","saturn","uranus","venus"]
            return planets
        }

        function disableOrbits(){
            merkur.toogleOrbitTransparency();
            venus.toogleOrbitTransparency();
            erde.toogleOrbitTransparency();
            mars.toogleOrbitTransparency();
            jupiter.toogleOrbitTransparency();
            saturn.toogleOrbitTransparency();
            uranus.toogleOrbitTransparency();
            neptun.toogleOrbitTransparency();
        }

        // Sonne

        Sonne {
        }

        PointLight {
            position: Qt.vector3d(0,0,0)
            scale: Qt.vector3d(1, 1, 1)
            brightness: 180
            constantFade: 1
            linearFade: .1
            quadraticFade: 0
        }

        // Planeten
        // Alle Planeten in einen SolarSystem.qml datei bringen
        // [!!] change size with property sphereScale:

        Merkur{
            id: merkur
            sphereDiffuseColor: "grey"
        }

        Venus {
            id: venus
            sphereDiffuseColor: "yellow"
        }

        Erde {
            id: erde
            sphereDiffuseColor: "#FF34B3"
        }

        Mars{
            id: mars
            sphereDiffuseColor: "#800020"
        }

        Jupiter{
            id: jupiter
            sphereDiffuseColor: "brown"
        }

        Saturn{
            id: saturn
            sphereDiffuseColor: "beige"
        }

        Uranus{
            id: uranus
            sphereDiffuseColor: "#6495ED"
        }

        Neptun{
            id: neptun
            sphereDiffuseColor: "#6A5ACD"
            // sphereScale: Qt.vector3d(3,3,3)
        }

        // [+] 2D Elements
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

        Fps {
            id: fpsCounter
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5

            Timer {
                interval: 1000
                repeat: true
                running: true
                onTriggered: {
                    window.fps=view.renderStats.fps
                }
            }
        }

        ButtonForm {
            id: button1
            buttonText : "Button 1";
            x: 690
            y: 496
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button2.top
        }

        ButtonForm {
            id: button2
            buttonText: "Button 2"
            x: 690
            y: 441
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: buttonSettings.top
        }

        ButtonForm {
            id: playButton
            width: 50
            height: 50
            scale: 1
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            buttonTextFontpixelSize: 15
            buttonText: "⏯"

            MouseArea {
                id: playButton_mouseArea
                anchors.fill: parent

                Connections {
                    target: playButton_mouseArea
                    onClicked: tooglePlayPause_helper();
                }
            }
        }

        ButtonForm {
            id: stopButton
            y: 540
            width: 35
            height: 35
            buttonText: qsTr("⏹")
            anchors.leftMargin: 5
            buttonTextFontpixelSize: 15
            anchors.bottomMargin: 10
            anchors.left: playButton.right
            anchors.bottom: parent.bottom

            MouseArea {
                id: stopButton_mouseArea
                anchors.fill: parent

                Connections {
                    target: stopButton_mouseArea
                    onClicked: resetSimulation_helper();
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
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:23;anchors_height:100;anchors_width:100}
}
##^##*/
