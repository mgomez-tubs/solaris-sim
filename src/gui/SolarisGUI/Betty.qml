import QtQuick3D 1.12
import QtQuick 2.12

Node {
    id: betty_obj
    rotationOrder: Node.XYZr
    orientation: Node.RightHanded

    Model {
        id: node20900_Brown_Betty_Teapot_v1
        rotationOrder: Node.XYZr
        orientation: Node.RightHanded
        source: "meshes/node20900_Brown_Betty_Teapot_v1.mesh"

        DefaultMaterial {
            id: node20900_Brown_Betty_Teapot_material
            diffuseColor: "#ff999999"
        }
        materials: [
            node20900_Brown_Betty_Teapot_material
        ]
    }
}
