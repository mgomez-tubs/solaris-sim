import QtQuick 2.12
import QtQuick3D 1.15
import QtQuick3D.Effects 1.15

Model {
    position: Qt.vector3d(0, 0, 0)
    scale: Qt.vector3d(1, 1, 1)
    source: "#Sphere"
    materials: [
        DefaultMaterial{
            id: material
            diffuseColor: "orange"
            emissiveColor: "yellow"
            emissiveFactor: 1
            lighting: DefaultMaterial.NoLighting
            diffuseMap: Texture {
                source: "/textures/2k_sun.jpg"
            }
        }
    ]
}

/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
