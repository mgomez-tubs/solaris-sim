import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Extras 1.4
import QtQuick3D 1.15
import QtQuick3D.Effects 1.15
import QtQuick.Controls 2.12
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0

import "qrc:/SolarSystem"
import "qrc:/MainGUI"

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
    signal resetSimulation()
    signal setSpeedMultiplier(real multiplier)

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
        camera: freeView

        // Handlers
        function planetCamera_handler(cameraName : String){
            if      (cameraName==="erde"){
                view.camera=solarSystem.erde.planetCamera
                erde.planetCamera.reset()
            }
            else if (cameraName==="saturn"){
                view.camera=erde.planetCamera
                erde.planetCamera.reset()
            }
            else if (cameraName==="defaultCamera"){
                view.camera=defaultCamera
                defaultCamera.reset()
            }
            else if (cameraName==="angledView"){
                view.camera=angledView
                angledView.reset()
            }
            else if (cameraName==="freeView"){
                freeView.position = view.camera.position
                freeView.eulerRotation = view.camera.eulerRotation
                view.camera=freeView
            }
        }

        // Functions
        function getPlanetList(){   // derzeit nicht benutzt
            var planets = ["merkur","venus","erde","mars","jupiter","saturn","uranus","venus"]
            return planets
        }

        function disableOrbits(){   // TODO : change name to toogle Orbits
            if(circularOrbits.visible){
                circularOrbits.visible=false
                console.log("Orbits disabled")
            } else {
                circularOrbits.visible = !circularOrbits.visible
                console.log("Orbits enabled")
            }
        }

        // Keyboard control - preferable in a separate file
        Keys.onPressed: {
            if(event.key === Qt.Key_I){
                        console.log("Rotated on the x axis");
                        erde.planetCameraEulerRotation.x+=10
                    }
            if(event.key === Qt.Key_O){
                        erde.planetCameraEulerRotation.x-=10
                        console.log("Rotated on the y axis");
                    }
            if(event.key === Qt.Key_K){
                        erde.planetCameraEulerRotation.y+=10
                        console.log("Rotated on the y axis");
                    }
            if(event.key === Qt.Key_L){
                        erde.planetCameraEulerRotation.y-=10
                        console.log("Rotated on the y axis");
                    }
            if(event.key === Qt.Key_N){
                        erde.planetCameraEulerRotation.z+=10
                        console.log("Rotated on the z axis");
                    }
            if(event.key === Qt.Key_M){
                        erde.planetCameraEulerRotation.z-=10
                        console.log("Rotated on the z axis");
                    }
        }

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

        PerspectiveCamera {
            id: freeView
            position: Qt.vector3d(0, 0, 1000)
            eulerRotation: Qt.vector3d(0, 0, 0)
        }

        PerspectiveCamera {
            id: defaultCamera
            function reset(){
                defaultCamera.position      = Qt.vector3d(0, 0, 1000);
                defaultCamera.eulerRotation = Qt.vector3d(0, 0, 0);
            }

            position: Qt.vector3d(0, 0, 1000)
            /*
            onPositionChanged: function(){
                rectangle1.text = "x: "      + Math.round(position.x)      + "\ny: "    + Math.round(position.y)      + "\nz: "    + Math.round(position.z)     +
                                  "\nrotx: " + Math.round(eulerRotation.x) + "\nroty: " + Math.round(eulerRotation.y) + "\nrotz: " + Math.round(eulerRotation.z)
            }*/
            eulerRotation: Qt.vector3d(0, 0, 0)        // arguments are in degrees, positive numbers rotate clockwise
        }

        PerspectiveCamera {
            id: angledView
            function reset(){
                angledView.position      = Qt.vector3d(0, -1228, 400)
                angledView.eulerRotation = Qt.vector3d(71, 0, 0)
            }
            position: Qt.vector3d(0, -1228, 400)
            eulerRotation: Qt.vector3d(71, 0, 0)        // arguments are in degrees, positive numbers rotate clockwise
            /*
            onPositionChanged: function(){
                rectangle1.text = "x: "      + Math.round(position.x)      + "\ny: "    + Math.round(position.y)      + "\nz: "    + Math.round(position.z)     +
                                  "\nrotx: " + Math.round(eulerRotation.x) + "\nroty: " + Math.round(eulerRotation.y) + "\nrotz: " + Math.round(eulerRotation.z)
            }*/
        }

        // Planet Camera

        Node {  /* maybe place this node in the camera*/
            Timer {
                id: cameraTimer
                running: false
                repeat: true
                interval: 16
                onTriggered:{
                    planetCamera.position = jupiter.spherePosition.times(Qt.vector3d(1.4,1.4,1.4))
                    planetCamera.lookAt(Qt.vector3d(0,0,0))
                }
            }

        // some nice camera
            PerspectiveCamera {     // no rendering w/o PerspectiveCamera!!
                id: planetCamera
                eulerRotation: Qt.vector3d(0,0,90)
                scale: Qt.vector3d(5,5,5)
        /*
                onPositionChanged: function(){
                    rectangle1.text = "x: "      + Math.round(position.x)      + "\ny: "    + Math.round(position.y)      + "\nz: "    + Math.round(position.z)     +
                                      "\nrotx: " + Math.round(eulerRotation.x) + "\nroty: " + Math.round(eulerRotation.y) + "\nrotz: " + Math.round(eulerRotation.z)
                }*/
            }
        }

        Node {
            Timer {
                id: cameraTimer2
                running: false
                repeat: true
                interval: 16
                onTriggered:{
                    //planetCamera2.position = jupiter.spherePosition.times(Qt.vector3d(-1.4,-1.4,-1.4))
                    planetCamera2.position = Qt.vector3d(0,0,0)
                    planetCamera2.eulerRotation = merkur.spherePosition
                    //console.log("looking at jupiter")
                }
            }
        // some nice camera
            PerspectiveCamera {     // no rendering w/o PerspectiveCamera!!
                id: planetCamera2
                eulerRotation: Qt.vector3d(0,0,90)
                scale: Qt.vector3d(5,5,5)
/*
                onPositionChanged: function(){
                    rectangle1.text = "x: "      + Math.round(position.x)      + "\ny: "    + Math.round(position.y)      + "\nz: "    + Math.round(position.z)     +
                                      "\nrotx: " + Math.round(eulerRotation.x) + "\nroty: " + Math.round(eulerRotation.y) + "\nrotz: " + Math.round(eulerRotation.z)
                }*/
            }
        }

        WasdController {
            //controlledObject: merkur.planetCamera
            controlledObject: freeView
        }


        // Sonne

        CircularOrbits{
            id: circularOrbits
        }

        SolarSystem {
            id: solarSystem
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


        /*
        Rectangle {
            property alias text : rectangle1_text.text
            id: rectangle1
            x: 601
            y: 43
            width: 245
            height: 193
            color: "#ffffff"
            visible: true

            Text {
                id: rectangle1_text
                text: qsTr("Z1")
                visible: true
                anchors.fill: parent
                lineHeight: 1
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 20

            }
        }*/
    }

    Layer_MainGUI {
        id: layer_MainGUI
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
