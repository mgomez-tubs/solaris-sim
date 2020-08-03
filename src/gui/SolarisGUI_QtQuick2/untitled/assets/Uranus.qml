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
        source: "meshes/uranus_kugel.mesh"

        DefaultMaterial {
            id: planet_material
            diffuseMap: Texture {
                source: "maps/2k_uranus.jpg"
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
        scale.x: 382.622
        scale.y: 374.833
        scale.z: 10.7838
        source: "meshes/uranus_torus.mesh"

        DefaultMaterial {
            id: ring_material
            diffuseMap: Texture {
                source: "maps/Uranus_rings.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
        }
        materials: [
            ring_material
        ]
    }
}
