import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "makemake"
    planetInfoString: "<h1>MAKEMAKE (Dwarf planet)</h1>Makemake is the second-brightest object in the Kuiper Belt as seen from Earth (while Pluto is the brightest). It takes about 305 Earth years for this dwarf planet to make one trip around the sun."


    Assets.Makemake {
        id: assetsMakemake
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
