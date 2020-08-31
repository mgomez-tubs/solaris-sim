import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "eris"
    planetInfoString: "<h1>ERIS (Dwarf planet)</h1>Eris was one of the first dwarf planets to be discovered in the solar system. It is almost the same size as Pluto, and its discovery directly led to the former ninth planet's demotion. Eris also has a moon, Dysnomia, which was discovered not long after Eris."

    Assets.Eris {
        id: assetsPluto
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
