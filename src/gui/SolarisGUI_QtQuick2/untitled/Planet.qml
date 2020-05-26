import QtQuick 2.15
import QtQuick3D 1.15

Node {
    property alias spherePosition : sphere.position
    property alias sphereDiffuseColor: material.diffuseColor
    property alias sphereScale: sphere.scale
    property alias sphereEmissiveColor: material.emissiveColor
    property alias sphereEmissiveFactor: material.emissiveFactor

    function receive(vector: vector3d){
        spherePosition = vector
    }

    Model {
        id: sphere
        position: Qt.vector3d(0, 0, 0)
        source: "#Sphere"
        scale: Qt.vector3d(.1, .1, .1)
        materials: [ DefaultMaterial {
                id: material
                diffuseColor: "blue"
                //lighting: DefaultMaterial.NoLighting;
            }
        ]

        Behavior on position {
            PropertyAnimation{
                easing.type: Easing.Linear;
            }
        }
    }
}


/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
