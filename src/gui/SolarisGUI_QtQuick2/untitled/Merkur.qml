import QtQuick 2.0
import QtQuick3D 1.15
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "merkur"

    Assets.Mercury{
        id: assetsMercury
        scale: Qt.vector3d(10,10,10)
    }
}
