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
                source: "maps/8k_venus_surface.jpg"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
        }
        materials: [
            planet_material
        ]
    }

    DirectionalLight {
        id: sun
        x: -1080.42
        y: 946.118
        z: 0.000127119
        eulerRotation.x: 90
        eulerRotation.y: -5.78086e-06
        eulerRotation.z: 48.6717
        color: "#ffffff9b"
    }

    DirectionalLight {
        id: sun_001
        x: 675.34
        y: -1175.96
        z: 128.767
        eulerRotation.x: 101.206
        eulerRotation.y: -5.91565
        eulerRotation.z: -138.436
        color: "#ff1e2326"
    }

    DirectionalLight {
        id: sun_002
        x: -1080.42
        y: 946.118
        z: 0.000127119
        eulerRotation.x: 90
        eulerRotation.y: -5.78086e-06
        eulerRotation.z: 48.6717
        color: "#ffffffff"
    }
}
