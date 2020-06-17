import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import QtQuick3D.Effects 1.15
import QtQuick.Controls 2.15
import QtQuick3D.Helpers 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Solaris")
    menuBar: MenuBar{
        Menu {
                   title: qsTr("&File")
                   Action { text: qsTr("&New...") }
                   Action { text: qsTr("&Open...") }
                   Action { text: qsTr("&Save") }
                   Action { text: qsTr("Save &As...") }
                   MenuSeparator { }
                   Action { text: qsTr("&Quit") }
               }
        Menu {
                    title: qsTr("&Edit")
                    Action { text: qsTr("Cu&t") }
                    Action { text: qsTr("&Copy") }
                    Action { text: qsTr("&Paste") }
                }
        Menu {
                    title: qsTr("&Help")
                    Action { text: qsTr("&About") }
                }
    }

    // FPS counter
    property int fps: 0

    // Signals
    signal mainWclosed()

    onFpsChanged: {
        fpsCounter.elementText=window.fps + " fps"
    }

    View3D {
        id: view
        anchors.fill: parent

        //! [environment]

        environment: SceneEnvironment{

            clearColor: "black"

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

        // Sonne

        Sonne {
        }

        PointLight {
            position: Qt.vector3d(0,0,0)
            scale: Qt.vector3d(1, 1, 1)
            brightness: 100
            constantFade: .5
            linearFade: 0
            quadraticFade: 0
        }


        // Planeten
        // change size with property sphereScale:

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

        }

        Node {
            Model {
                id: grid
                geometry: GridGeometry{
                    name: "grid"    // for whatever reason wont work w/o a grid
                    horizontalLines: 50
                    verticalLines: 50
                    horizontalStep: 50
                    verticalStep: 50
                }
                //scale: Qt.vector3d(50,50,50)
                materials: [
                    DefaultMaterial {
                        emissiveColor: "gray"
                        lighting: DefaultMaterial.NoLighting
                    }
                ]
            }
        }

        Node {

        }

/*
        DirectionalLight {
            position: Qt.vector3d(10000,0,0)
            eulerRotation: Qt.vector3d(-1, 0, 0)
            //rotation: Qt.quaternion(1,0,0,0)
        }*/


        // [+] 2D Elements
        Button {
            id: button
            buttonText : "Button 0"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
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

        Button {
            id: button1
            buttonText : "Button 1"
            x: 690
            y: 496
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button.top
        }

        Button {
            id: button2
            buttonText: "Button 2"
            x: 690
            y: 441
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button1.top
        }
    }

    onClosing:  {
        mainWclosed()
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}
}
##^##*/
