import QtQuick 2.15
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
            emissiveFactor: .75
        }
    ]
}

/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
