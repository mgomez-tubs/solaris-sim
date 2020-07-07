import QtQuick3D 1.15
import QtQuick 2.15

Node {
    id: rootNode

    PerspectiveCamera {
        id: camera
        x: -1429.62
        y: 1257.56
        z: 2401.39
        eulerRotation.x: -154.331
        eulerRotation.y: 30.4814
        eulerRotation.z: -180
        fieldOfView: 25.3608
        fieldOfViewOrientation: Camera.Horizontal
    }

    Model {
        id: kugel
        eulerRotation.x: -90
        scale.x: 192.587
        scale.y: 192.587
        scale.z: 192.587
        source: "meshes/saturn_main.mesh"

        DefaultMaterial {
            id: planet_material
            diffuseMap: Texture {
                source: "maps/8k_saturn.jpg"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }

        }
        materials: [
            planet_material
        ]
    }

    Model {
        id: torus
        eulerRotation.x: 90
        eulerRotation.z: -180
        scale.x: 354.811
        scale.y: 347.588
        scale.z: 10
        source: "meshes/saturn_ring.mesh"

        DefaultMaterial {
            id: ring_material
            diffuseMap: Texture {
                source: "maps/8k_saturn_ring_alpha.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
        }
        materials: [
            ring_material
        ]
    }
}
