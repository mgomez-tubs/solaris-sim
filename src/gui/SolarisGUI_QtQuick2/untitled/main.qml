
import QtQuick 2.14
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
    menuBar: MenuBar{       // There is a bug with the menu bar!!
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
/*
        AxisHelper{
            enableXYGrid: false
            enableXZGrid: false
            enableYZGrid: false
        }*/

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

        Node {
            opacity: 0.25;
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


        // [+] 2D Elements
        ButtonForm {
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

        ButtonForm {
            id: button1
            buttonText : "Button 1";
            x: 690
            y: 496
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button.top
        }

        ButtonForm {
            id: button2
            buttonText: "Button 2"
            x: 690
            y: 441
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button1.top
        }

        ButtonForm {
            id: buttonForm
            width: 50
            height: 50
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            buttonTextFontpixelSize: 20
            buttonText: "[P]"
        }

        ButtonForm {
            id: buttonForm1
            y: 540
            width: 35
            height: 35
            buttonText: qsTr("[S]")
            anchors.leftMargin: 5
            buttonTextFontpixelSize: 20
            anchors.bottomMargin: 10
            anchors.left: buttonForm.right
            anchors.bottom: parent.bottom
        }

        ButtonForm {
            id: buttonForm2
            y: 555
            width: 35
            height: 35
            anchors.left: buttonForm1.right
            anchors.leftMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            buttonTextFontpixelSize: 20
            buttonText: qsTr("[T]")
        }
    }

    onClosing:  {
        mainWclosed()
    }
}




/*##^##
Designer {
    D{i:39;anchors_x:8}D{i:40;anchors_x:8}
}
##^##*/
