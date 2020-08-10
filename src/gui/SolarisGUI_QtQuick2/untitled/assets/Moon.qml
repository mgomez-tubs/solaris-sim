import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode

    Model {
        id: kugel
        eulerRotation.x: -90
        scale.x: 192.587
        scale.y: 192.587
        scale.z: 192.587
        source: "meshes/kugel.mesh"

        DefaultMaterial {
            id: planet_material
            diffuseColor: "#ffcccccc"
        }
        materials: [
            planet_material
        ]
    }
}
