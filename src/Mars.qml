import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "mars"
    Assets.Mars{
        id: assetsMars
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
