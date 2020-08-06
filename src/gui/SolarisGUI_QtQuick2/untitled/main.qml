import QtQuick 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls 2.12

import QtQuick3D 1.15
import QtQuick3D.Effects 1.15
import QtQuick3D.Helpers 1.15

import DrawCircleQt 1.0

import "qrc:/SolarSystem"
import "qrc:/MainGUI"

import "DefaultKeys.js" as DefaultKeys

ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 600
    title: qsTr("Solaris")

    //          FPS counter
    property int fps: 0

    //          Signals
    signal setPreset_main()
    signal mainWclosed()
    signal tooglePlayPause()
    signal resetSimulation()
    signal setSpeedMultiplier(real multiplier)

    //          Signal Helpers
    function setPreset_main_helper(){
        console.log("Funktion setPreset_main_helper() wurde aufgerufen.")
        setPreset_main()
    }

    function tooglePlayPause_helper(){
        tooglePlayPause()
    }

    function resetSimulation_helper(){
        resetSimulation();
    }

    //          Handlers
    onFpsChanged: {
        fpsCounter.elementText=window.fps + " fps"
    }

    onClosing:  {
        mainWclosed()
    }

    View3D {
        id: view
        objectName: "view"
        anchors.fill: parent
        camera: centerCamera

        //                           Handlers                            //
        function planetCamera_handler(cameraName : String){
            if (cameraName==="defaultCamera"){
                view.camera=topCamera
                topCamera.reset()
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

        property Node currentPlanet : undefined
        function setCurrentPlanet(planet : Node) {
            currentPlanet = planet;
        }


        //                           Functions                           //
        function getPlanetList(){   // derzeit nicht benutzt
            var planets = ["merkur","venus","erde","mars","jupiter","saturn","uranus","venus"]
            return planets
        }

        property var orbits : []
        /* Planet Orbits */

        function receiveOrbit(orbit: double){
            // Push Orbit in Orbits list
            orbits.push(orbit);
            // Insert new Orbit
            orbitSpawner.addComponent(orbit);
        }

        property bool showOrbits : false

        onOrbitsChanged:
        {
            console.log("orbits changed")
            // Delete last
            orbitSpawner.removeAllComponents();
            for(var i = 0; i < orbits.length; i++) {
                addComponent(orbits[i]);
            }
        }

        onShowOrbitsChanged:
            if(showOrbits){
                /*
                for(var i = 0; i<12;i++)
                    orbitSpawner.addComponent(i*100)
                    */

            } else {
                orbitSpawner.removeAllComponents();
                console.log("Orbits disabled")
            }

/*
        function toogleOrbits(){
            if(circularOrbits.visible){
                circularOrbits.visible=false
                console.log("Orbits disabled")
            } else {
                circularOrbits.visible = !circularOrbits.visible
                console.log("Orbits enabled")
            }
        }
*/

        //          Keyboard control - preferable in a separate file?    //
        Keys.onPressed: DefaultKeys.func(event);

        //! [environment]
        environment: SceneEnvironment{
            clearColor: "black"

            effects: [
                /*
                HDRBloomTonemap{
                    bloomThreshold: .95

                }*/

            ]

            // Qt 2.15
            antialiasingMode: SceneEnvironment.MSAA            // Multisample AA
            antialiasingQuality: "VeryHigh"         // High quality


            backgroundMode: SceneEnvironment.Color
        }

        Node {
            id: cameraPivot
            pivot: Qt.vector3d(0,0,0)
            PerspectiveCamera {
                id: freeView
                position: Qt.vector3d(0, 0, 1000)
                eulerRotation: Qt.vector3d(0, 0, 0)
            }
        }

        PerspectiveCamera {
            id: topCamera
            function reset(){
                topCamera.position      = Qt.vector3d(0, 0, 7960);
                topCamera.eulerRotation = Qt.vector3d(0, 0, 0);
            }

            position: Qt.vector3d(0, 0, 1500)
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
        Node {
            id: node_centerCamera
            property real distance : 1400
            property real angle : 25
            property real currentAngle : angle + 180

            eulerRotation: Qt.vector3d(90,0,0)

            Node {
                eulerRotation: Qt.vector3d(-19.7, -0.700003, 0)

                PerspectiveCamera {
                     id: centerCamera
                     function reset(){
                         centerCamera.position = Qt.vector3d(0, -1228, 400)
                     }
                     position: Qt.vector3d(0, 0, node_centerCamera.distance)

                     //on position changed: change euler rotation
                     eulerRotation: Qt.vector3d(0, 0, 0)
                     clipNear: 1
                     fieldOfViewOrientation: Camera.Vertical
                }
            }
        }

        InputController{
            // In order to rotate the camera around an object:
            // Place the camera inside a node
            // Set the pivot of that node to the coordinate origin
            // and connect this controlledObject with that [!] Node (also: cameras parent)
            controlledObject: view.camera.parent
            keysEnabled: true       // Careful, this disables keys GLOBALLY (also Keys in DefaultKeys)
        }

        CircularOrbits  { id: circularOrbits}

        SolarSystem     { id: solarSystem}

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

         //          MouseArea on WHOLE view, to make objects "pickable"  //
        MouseArea {
            id: viewMouseArea
            anchors.fill: parent
            onClicked: {
                var clickPos = view.pick(mouse.x,mouse.y);
                if(clickPos.objectHit){
                    var pickedObject = clickPos.objectHit;
                    pickedObject.isPicked = !pickedObject.isPicked;
                    console.log("Planet with id: " + pickedObject.objectName + " was clicked!");
                }
            }
            onDoubleClicked: {
                var clickPos = view.pick(mouse.x,mouse.y);
                if(clickPos.objectHit){
                    var pickedObject = clickPos.objectHit;
                    pickedObject.isPicked = !pickedObject.isPicked;
                    // Toggle the isPicked property for the model
                    view.camera=pickedObject.planetCamera
                    view.camera.reset();

                    // Set current planet
                    view.setCurrentPlanet(pickedObject)

                    // Change Layer to planet layer                                                         [!]
                    // view.layerHandler("PlanetGUI");

                }
            }
            onWheel: {              // [!] refine the wheel handler
                if(view.camera.position.z>250){
                    view.camera.position.z += wheel.angleDelta.y/.5;
                    return;
                } else {
                    view.camera.position.z += wheel.angleDelta.y/50;
                }

            }
        }

        function layerHandler(layer : String){
            if          (layer === "MainGUI"){
                layerLoader.source = "MainGUI/Layer_MainGUI.qml"
                view.camera.restore();
                return
            }
            else if   (layer === "PlanetGUI"){
                // Save current camera properties
                view.camera.backUp();
                // Change the camera to planet mode
                // Shift current camera to the right
                view.camera.position                = Qt.vector3d(-30,0,57);
                view.camera.parent.eulerRotation    = Qt.vector3d(-5.5,76,0);

                layerLoader.source = "PlanetGUI/Layer_PlanetGUI.qml"
                return
            }
        }

        // Layer loader
        Item {
            anchors.fill: parent
            Loader {
                anchors.fill: parent
                id: layerLoader
                source: "MainGUI/Layer_MainGUI.qml"
                //source: "PlanetGUI/Layer_PlanetGUI.qml"
            }
        }

        Node {
            id: orbitSpawner
            property var orbitCount: 0
            property var instances : []

            function addComponent(radius: double){
                var orbitComponent = Qt.createComponent("OrbitKreis.qml");
                if (orbitComponent.status === Component.Ready){
                    let instance = orbitComponent.createObject(
                            orbitSpawner,
                            {
                                "opacity": .45,
                                "name"   : orbitCount,
                                "radius" : radius
                            });
                    instances.push(instance);
                }
                orbitCount++
            }

            function removeAllComponents(){
                for (var i = orbitCount; i<view.orbits.length; i--){
                    let instance = instances.pop()
                    instance.destroy();
                }
            }
        }

        Component.onCompleted: {
            view.showOrbits = true;
        }


    }
//[!]//////// HERE ENDS View3D ///////////[!]//
//  nothing below this line will be rendered!!

}


/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
