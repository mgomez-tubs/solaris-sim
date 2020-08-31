import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode

    Model {
        id: kugel
        eulerRotation.x: -90
        scale.x: 100
        scale.y: 100
        scale.z: 100
        source: "meshes/kugel.mesh"

        DefaultMaterial {
            id: planet_material
            diffuseMap: Texture {
                source: "maps/8k_jupiter.jpg"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
        }
        materials: [
            planet_material
        ]
    }
}
