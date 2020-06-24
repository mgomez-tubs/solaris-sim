import QtQuick3D 1.15
import QtQuick 2.12

Node {
    property alias merkur   : merkur
    property alias venus    : venus
    property alias erde     : erde
    property alias mars     : mars
    property alias jupiter  : jupiter
    property alias saturn   : saturn
    property alias uranus   : uranus
    property alias neptun   : neptun

    Sonne {
        id: sonne
    }

    PointLight {
        position: Qt.vector3d(0,0,0)
        brightness: 180
        constantFade: 1
        linearFade: .1
        quadraticFade: 0
    }

    // + implement something like https://stackoverflow.com/questions/31206813/how-to-find-qml-item-by-its-string-id
    // to access planets (and further himmleskörper) by string name
    // [!!] change size with property sphereScale:

    Merkur {
        id: merkur
        planetDiffuseColor: "gray"
    }

    Venus {
        id: venus
        planetDiffuseColor: "yellow"
    }

    Erde {
        id: erde
        planetDiffuseColor: "#FF34B3"
    }

    Mars{
        id: mars
        planetDiffuseColor: "#800020"
    }

    Jupiter{
        id: jupiter
        planetDiffuseColor: "brown"
    }

    Saturn{
        id: saturn
        planetDiffuseColor: "beige"
    }

    Uranus{
        id: uranus
        planetDiffuseColor: "#6495ED"
    }

    Neptun{
        id: neptun
        planetDiffuseColor: "#6A5ACD"
    }
}
