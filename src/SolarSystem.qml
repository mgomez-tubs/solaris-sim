import QtQuick3D 1.15
import QtQuick 2.12

Node {
    id: solarSystem
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
        linearFade: .05
        quadraticFade: 0
    }

    // + implement something like https://stackoverflow.com/questions/31206813/how-to-find-qml-item-by-its-string-id
    // to access planets (and further himmleskörper) by string name
    // [!!] change size with property sphereScale:

    Merkur {
        id: merkur
    }

    Venus {
        id: venus
    }

    Erde {
        id: erde
    }

    Mars{
        id: mars
    }

    Jupiter{
        id: jupiter
    }

    Ceres{
        id: ceres
    }

    Saturn{
        id: saturn
    }

    Uranus{
        id: uranus
    }

    Neptun{
        id: neptun
    }

    Pluto{
        id : pluto
    }
/*
    Charon{
        id: charon
    }
*/
    Haumea{
        id: haumea
    }

    MakeMake{
        id: makemake
    }

    Eris{
        id: eris
    }

}
