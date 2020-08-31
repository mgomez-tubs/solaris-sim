import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "pluto"
    planetInfoString: "<h1>PLUTO (Dwarf planet)</h1>Pluto is the largest known dwarf planet in the Solar System, discovered in 1930. It was thought to be the 9th planet of our system for 75 years until the discovery of Eris and other similar objects that led to its demotion from a planet to a dwarf planet in 2006."


    Assets.Pluto_normal {
        id: assetsPluto
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
