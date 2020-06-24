import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0
import QtQuick 2.0
import Qt3D.Render 2.15

Node {
    id: rootNode

    //property alias spherePosition : sphere.position
    property alias planetPosition: rootNode.position
    property alias planetDiffuseColor: material.diffuseColor
    property alias planetScale: model.scale
    property alias planetEmissiveColor: material.emissiveColor
    property alias planetSource : model.source

    property real  currentAngle : 0

    property alias planetCamera: planetCamera
    property alias planetCameraPosition : planetCamera.position
    property alias planetCameraEulerRotation : planetCamera.eulerRotation

    function receive(vector: vector3d, angle : double){
        planetPosition = vector;
        currentAngle = angle * (180/Math.PI)+180;
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
        onIsPickedChanged: function () {
            console.log("You clicked the planet " + rootNode.objectName + "!");
        }
    }

    Node{
        id: spherenode
        eulerRotation: Qt.vector3d(0,0,currentAngle)

        Model {
            id: model
            source: "#Sphere"
            scale: Qt.vector3d(.2, .2, .2)
            position: Qt.vector3d(0,0,0)
            materials: [ DefaultMaterial {
                    id: material
                    diffuseColor: "blue"
                    //lighting: DefaultMaterial.NoLighting;
                }
            ]

            PerspectiveCamera {
                 id: planetCamera
                 function reset(){
                     planetCamera.position      = Qt.vector3d(150,0,0)
                     planetCamera.eulerRotation = Qt.vector3d(0,90,90)
                 }
                 position: Qt.vector3d(250, 0, 0)
                 eulerRotation: Qt.vector3d(0, 90, 90)
                 clipNear: 50
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
