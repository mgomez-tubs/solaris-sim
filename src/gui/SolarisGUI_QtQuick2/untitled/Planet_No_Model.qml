import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0
import QtQuick 2.15

Node {
    id: rootNode
    property alias planetPosition: rootNode.position

    property alias planetScale: rootNode.scale

    property real  currentAngle : 0

    property alias planetCamera: planetCamera
    property alias planetCameraPosition : planetCamera.position
    property alias planetCameraEulerRotation : planetCamera.eulerRotation

    eulerRotation: Qt.vector3d(90,0,0)

    function receive(vector: vector3d, angle : double){
        planetPosition = vector;
        currentAngle = angle * (180/Math.PI)+180;
    }

    function receiveScale (vector: vector3d,){
        planetScale = vector;
    }

    Model {
        id: sphereHitbox
        source: "#Sphere"
        visible: false
        position: Qt.vector3d(0,0,0)
        opacity: 0.5
        scale: Qt.vector3d(.25, .25, .25)
        materials: [ DefaultMaterial {
                id: hitbox_material
                diffuseColor: "yellow"
                lighting: DefaultMaterial.NoLighting;
            }
        ]
        pickable: true
        property bool isPicked: false
        property alias planetCamera :rootNode.planetCamera
        property alias objectName: rootNode.objectName
    }

    Node{
        id: spherenode
        eulerRotation: Qt.vector3d(0,currentAngle+90,0)

        // AxisHelper { enableXYGrid: false; enableXZGrid: false ; enableYZGrid: false }

        Node {
            id: cameraPivot
            pivot: Qt.vector3d(0,0,0)
            PerspectiveCamera {
                 id: planetCamera
                 function reset(){
                     planetCamera.position = Qt.vector3d(0,0,75)
                     planetCamera.eulerRotation = Qt.vector3d(0,0,0)
                 }
                 position: Qt.vector3d(0, 0, 75)
                 eulerRotation: Qt.vector3d(0, 0, 0)
                 clipNear: 1
                 fieldOfViewOrientation: Camera.Vertical
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
