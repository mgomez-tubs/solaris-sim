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

        Merkur{
            id: merkur
            sphereDiffuseColor: "orange"
        }

        Venus {
            id: venus
            sphereDiffuseColor: "green"
        }

        Erde {
            id: erde
            sphereDiffuseColor: "blue"
        }

        Mars{
            id: mars
            sphereDiffuseColor: "red"
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
            x: 690
            y: 496
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button.top
        }

        Button {
            id: button2
            x: 690
            y: 441
            anchors.rightMargin: 10
            anchors.right: parent.right
            anchors.bottomMargin: 1
            anchors.bottom: button1.top
        }
    }
}




/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
