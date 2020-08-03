import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "erde"
    Assets.Earth_day{
        id: assetsErde
        scale: Qt.vector3d(0.1,0.1,0.1)
    }

    Planet {
        planetPosition: Qt.vector3d(50,0,0)
        planetScale: Qt.vector3d(0.02,0.02,0.02)
    }
}
