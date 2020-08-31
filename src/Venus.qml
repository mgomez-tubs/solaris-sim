import QtQuick 2.15
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "venus"

    Assets.Venus{
        id: assetsVenus
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
