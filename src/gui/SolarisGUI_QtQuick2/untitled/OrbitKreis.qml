import QtQuick 2.0
import QtQuick3D 1.15
import DrawCircleQt 1.0
Node {
    property alias radius:  circle.radius
    property alias name:    circle.name
    Model{

            id: customGeometry
            geometry: DrawCircleQt{
                id: circle
                centerPoint: Qt.vector3d(0,0,0)
                lineSteps: 100
                }
            materials: [
                DefaultMaterial {
                    emissiveColor: "gray"
                    lighting: DefaultMaterial.NoLighting
                }
            ]
        }

}



