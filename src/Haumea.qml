import QtQuick 2.0
import "qrc:/assets" as Assets

Planet_No_Model {
    objectName: "haumea"
    planetInfoString: "<h1>HAUMEA (Dwarf planet)</h1>Located in the Kuiper Belt beyond Neptune’s orbit, the dwarf planet Haumea is an oval-shaped object with a radius of about 385 miles (just under 10 times smaller than Earth), and two moons, Namaka and Hi’iaka."


    Assets.Haumea {
        id: assetsHaumea
        scale: Qt.vector3d(0.1,0.1,0.1)
    }
}
