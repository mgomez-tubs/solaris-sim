import QtQuick 2.15

import QtQuick3D 1.15

Node {
    visible: false
    opacity: .45
    function orbitName(){
        var a = Math.random();
        return a;
    }
    OrbitKreis{
        name: orbitName()
        radius: 100
    }
    OrbitKreis{
        id: orbitKreis_venus
        name: orbitName()
        radius: 200
    }
    OrbitKreis{
        id: orbitKreis_erde
        name: orbitName()
        radius: 300
    }
    OrbitKreis{
        id: orbitKreis_mars
        name: orbitName()
        radius: 400
    }
    OrbitKreis{
        id: orbitKreis_jupiter
        name: orbitName()
        radius: 500
    }
    OrbitKreis{
        id: orbitKreis_saturn
        name: orbitName()
        radius: 600
    }
    OrbitKreis{
        id: orbitKreis_uranus
        name: orbitName()
        radius: 700
    }
    OrbitKreis{
        id: orbitKreis_neptun
        name: orbitName()
        radius: 800
    }
}


// about orbitKreis.name:
/* - the renderer wont display the orbit circle if a name is not set */
/* - and will almost always crash with no errors if two geometries have the same name */
/* currently assigning random values at start */
/* if app crashes it might be this */
