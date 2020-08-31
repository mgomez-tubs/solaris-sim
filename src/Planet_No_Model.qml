import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15
import DrawCircleQt 1.0
import QtQuick 2.15

/*

    This Object is to be used only for planets for which an external model is providen.

  */

Node {
    id: rootNode
    property alias planetPosition: rootNode.position
    property alias planetScale: rootNode.scale
    property real  currentAngle : 0
    property alias planetCamera: planetCamera
    property alias planetCameraPosition : planetCamera.position
    property alias planetCameraEulerRotation : planetCamera.eulerRotation
    property alias planetTilt: planetCamera.eulerRotation.y
    property string planetInfoString : " "
    property alias planetIsPickable: sphereHitbox.pickable

    eulerRotation: Qt.vector3d(90,0,0)

    // Receiver of planet location in vector form
    // vector: Location des planets as as vector
    // angle: Current angle of the planet
    function receive(vector: vector3d, angle : double){
        planetPosition = vector;
        currentAngle = angle * (180/Math.PI)+180;
    }

    // Receiver of planet scaling in vector form
    // vector: Vector for scaling the planet sphere (in x,y,z coordinates)
    function receiveScale (vector: vector3d,){
        planetScale = vector;
    }

    // Receriver of planet information texts
    // str: String with text to be displayed (using HTML text syntax)
    function receiveInfoString (str : string){
        planetInfoString = str;
    }

    Model {
        id: sphereHitbox
        source: "#Sphere"
        visible: false
        position: Qt.vector3d(0,0,0)
        opacity: 0.5
        scale: Qt.vector3d(.25, .25, .25)
        materials: [ DefaultMaterial {
                id: hitbox_material
                diffuseColor: "yellow"
                lighting: DefaultMaterial.NoLighting;
            }
        ]
        pickable: true
        property bool isPicked: false
        property alias planetCamera :rootNode.planetCamera
        property alias objectName: rootNode.objectName
        property alias planetInfoString: rootNode.planetInfoString

    }

    Node{
        id: spherenode
        eulerRotation: Qt.vector3d(0,currentAngle+90,0)

        /* README FIRST : PLANET CAMERA

         planet + pivot x                    (camera)
           (  x  )--------------------------- >[o]

          The camera consists of a "Pivot Node" (cameraPivot) and the camera (planetCamera) itself.

          Because of Qt Limitations, a pivot can not set to a camera, and
          instead, the camera needs to be placed inside a Node container.

          The reason for the pivot is to enable the user to orbit around the planet.
          This is achieved through a Qt QML Object called WasdController. This Node is passed to
          that Object, which handles all movements and rotations.

          Following this logic, it wouldn't make sense to control the rotation of the planets camera
          directly and instead all rotations should be applied to cameraPivot.

          Nevertheless the position of the camera should be controlled directly though the planetCamera
          since it wouldn't make sense to change the position of the pivot.

          +++++++++++++ TLDR +++++++++++++++
          for euler rotations:              view.camera.parent.eulerRotation
          for setting camera position:      view.camera.position

        */

        /*
                Planet Camera
        */
        Node {
            id: cameraPivot
            pivot: Qt.vector3d(0,0,0)

            PerspectiveCamera {
                id: planetCamera
                property var positionBackup : Qt.vector3d(0,0,0)
                property var rotationBackup : Qt.vector3d(0,0,0)


                // Back up position of the planet (used when changing Main GUI Layer to Planet View Layer)
                function backUp(){
                    var currentPosition = planetCamera.position;
                    var currentEulerRotation = cameraPivot.eulerRotation;
                    planetCamera.positionBackup = Qt.vector3d(currentPosition.x,currentPosition.y,currentPosition.z)
                    planetCamera.rotationBackup = Qt.vector3d(currentEulerRotation.x,currentEulerRotation.y,currentEulerRotation.z)
                }

                // Restore the position of the planet before the planet view was activated (used when changing Main GUI Layer to Planet View Layer)
                function restore(){
                    planetCamera.position = planetCamera.positionBackup;
                    cameraPivot.eulerRotation = planetCamera.rotationBackup;
                }

                // Reset the position of the Camera
                function reset(){
                    planetCamera.position = Qt.vector3d(0,0,75)
                    planetCamera.parent.eulerRotation = Qt.vector3d(0,0,0)
                }

                position: Qt.vector3d(0, 0, 75)
                eulerRotation: Qt.vector3d(0, 0, 0)
                clipNear: 1
                fieldOfViewOrientation: Camera.Vertical

            }
        }
    }
}


/*##^##
Designer {
    D{i:0;3d-view:false}
}
##^##*/
