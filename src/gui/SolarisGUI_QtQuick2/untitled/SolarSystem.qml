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
        scale: Qt.vector3d(1, 1, 1)
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
        sphereDiffuseColor: "gray"
    }

    Venus {
        id: venus
        sphereDiffuseColor: "yellow"
    }

    Erde {
        id: erde
        sphereDiffuseColor: "#FF34B3"
    }

    Mars{
        id: mars
        sphereDiffuseColor: "#800020"
    }

    Jupiter{
        id: jupiter
        sphereDiffuseColor: "brown"
    }

    Saturn{
        id: saturn
        sphereDiffuseColor: "beige"
    }

    Uranus{
        id: uranus
        sphereDiffuseColor: "#6495ED"
    }

    Neptun{
        id: neptun
        sphereDiffuseColor: "#6A5ACD"
        // sphereScale: Qt.vector3d(3,3,3)
    }
}
