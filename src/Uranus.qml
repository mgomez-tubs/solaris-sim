import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "uranus"

    Assets.Uranus{
        id: assetsUranus
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
