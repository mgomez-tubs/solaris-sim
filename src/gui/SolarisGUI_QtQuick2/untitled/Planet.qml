import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0
import QtQuick 2.0

Node {

    id: rootNode
    //property alias spherePosition : sphere.position
    property alias spherePosition: rootNode.position
    property alias sphereDiffuseColor: material.diffuseColor
    property alias sphereScale: sphere.scale
    property alias sphereEmissiveColor: material.emissiveColor

    property real currentAngle : 0

    property alias planetCamera: planetCamera
    property alias planetCameraPosition : planetCamera.position
    property alias planetCameraEulerRotation : planetCamera.eulerRotation

    function receive(vector: vector3d, angle : double){
        spherePosition = vector;
        currentAngle = angle * (180/Math.PI)+180;
    }

    function orbitName(){
        var a = Math.random();
        return a;
    }

    Node{
        id: spherenode
        eulerRotation: Qt.vector3d(0,0,currentAngle)

        AxisHelper{
            visible: false
            enableXYGrid : false
            enableXZGrid : false
            enableYZGrid : false
        }

        Model {
            id: sphere
            source: "#Sphere"
            scale: Qt.vector3d(.2, .2, .2)
            position: Qt.vector3d(0,0,0)
            castsShadows: true
            receivesShadows: true
            materials: [ DefaultMaterial {
                    id: material
                    diffuseColor: "blue"
                    //lighting: DefaultMaterial.NoLighting;
                }
            ]
            Node{
                id: cameraNode


                PerspectiveCamera {
                    id: planetCamera
                    function reset(){
                        planetCamera.position      = Qt.vector3d(150,0,0)
                        planetCamera.eulerRotation = Qt.vector3d(0,90,90)
                    }
                    position: Qt.vector3d(150, 0, 0)
                    eulerRotation: Qt.vector3d(0, 90, 90)
                    clipNear: 50
                    fieldOfViewOrientation: Camera.Vertical
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
