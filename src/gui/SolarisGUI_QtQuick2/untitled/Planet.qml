import QtQuick3D 1.15
import DrawCircleQt 1.0

Node {
    id: rootNode
    property alias spherePosition : sphere.position
    property alias sphereDiffuseColor: material.diffuseColor
    property alias sphereScale: sphere.scale
    property alias sphereEmissiveColor: material.emissiveColor
    property alias orbitTransparency : orbitKreisNode.opacity
    property bool showOrbit : true

    function receive(vector: vector3d){
        spherePosition = vector
    }

    function setRadiusKreisBahn(rad : double){
        orbitKreis.radius = rad
    }

    function toogleOrbitTransparency(){
        showOrbit = !showOrbit
        console.log("Tranparency was set to",showOrbit)
        orbitKreisNode.visible  = showOrbit;
    }

    function whatName(name){
        console.log("Name changed for ",name);
    }

    function orbitName(){
        var a = Math.random();
        return a;
    }


    Model {
        id: sphere
        position: Qt.vector3d(0, 0, 0)
        source: "#Sphere"
        scale: Qt.vector3d(.2, .2, .2)
        materials: [ DefaultMaterial {
                id: material
                diffuseColor: "blue"
                //lighting: DefaultMaterial.NoLighting;
            }
        ]
    }
    Node {
        id: orbitKreisNode
        opacity: .45
        OrbitKreis{
            id: orbitKreis
            name: orbitName()                          // this will make it usable for now . . . //
                                                        /* this implmentation is very important */
                                                        /* - the renderer wont display the orbit circle if a name is not set */
                                                        /* - and will almost always crash with no errors if two geometries have the same name */
                                                        /* currently assigning random values at start */
                                                        /* if app crashes it might be this */
        }
    }
}


/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
