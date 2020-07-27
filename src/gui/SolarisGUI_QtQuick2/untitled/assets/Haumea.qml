import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode_3

    Model {
        id: kugel_3
        eulerRotation.x: -90
        scale.x: 200
        scale.y: 200
        scale.z: 137
        source: "meshes/kugel_3.mesh"

        DefaultMaterial {
            id: planet_material_3
            diffuseColor: "#ffcccccc"
        }
        materials: [
            planet_material_3
        ]
    }
}
