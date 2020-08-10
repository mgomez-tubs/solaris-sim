import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "pluto"

    Assets.Pluto_normal {
        id: assetsPluto
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
