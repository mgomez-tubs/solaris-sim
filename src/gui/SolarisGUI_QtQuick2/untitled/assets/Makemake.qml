import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode_5

    Model {
        id: kugel_5
        eulerRotation.x: -90
        scale.x: 192.587
        scale.y: 192.587
        scale.z: 192.587
        source: "meshes/kugel_5.mesh"

        DefaultMaterial {
            id: planet_material_5
            diffuseColor: "#ffcccccc"
        }
        materials: [
            planet_material_5
        ]
    }
}
