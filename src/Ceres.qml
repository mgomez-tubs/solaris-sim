import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "ceres"

    Assets.Ceres{
        id: assetsCeres
        scale: Qt.vector3d(0.1,0.1,0.1)
    }

    planetInfoString: "<h1>CERES (Dwarf planet)</h1>Dwarf planet Ceres is the largest object in the asteroid belt between Mars and Jupiter and the only dwarf planet located in the inner solar system."
}
