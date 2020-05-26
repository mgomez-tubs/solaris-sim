import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15

Window {

    id: window
    visible: true
    width: 800
    height: 600
    title: qsTr("Solaris")

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
            antialiasingMode: "MSAA"            // Multisample AA
            antialiasingQuality: "High"         // High quality
            backgroundMode: SceneEnvironment.Color

        }
        //! [environment]

        PerspectiveCamera {     // no rendering w/o PerspectiveCamera!!
            position: Qt.vector3d(0, 0, 1000)
            eulerRotation: Qt.vector3d(0, 0, 0)        // arguments are in degrees, positive numbers rotate clockwise
        }

        // Sonne

        Sonne {
            id: sonne
            sphereDiffuseColor: "#ffee00";
            sphereEmissiveColor: "white"
            sphereEmissiveFactor: 1
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
    }
}



/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
