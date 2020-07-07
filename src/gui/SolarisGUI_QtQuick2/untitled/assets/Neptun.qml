import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode

    PerspectiveCamera {
        id: camera
        x: -187.368
        y: -1.99031
        z: 1798.66
        eulerRotation.x: 180
        eulerRotation.y: 1.11559e-05
        eulerRotation.z: 180
        fieldOfView: 25.3608
        fieldOfViewOrientation: Camera.Horizontal
    }

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
                source: "maps/2k_neptune.jpg"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
        }
        materials: [
            planet_material
        ]
    }
}
