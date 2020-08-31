import QtQuick 2.4
import QtQuick 2.2
import QtQuick.Dialogs 1.0
import QtQuick.Controls 2.15
import Qt.labs.platform 1.1

Item {
    width: 200
    height: 200

    // Menu Container
    Rectangle {
        id: rectangle
        height: 200
        color: "#3f0641"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        DropDownMenu {
            id: menuView
            x: 8
            maxheight: 100
            rowHeight: 200
            maximized: false
            menuClip: true
            clip: false
            elementText: "View"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: rectangle1
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: rectangle1_text
                    text: qsTr("Show planets orbits")
                    anchors.leftMargin: 20
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }

                Switch {
                    id: rectangle1_switch
                    x: 0
                    y: 0
                    width: 70
                    height: 35
                    text: ""
                    checkable: true
                    focusPolicy: Qt.NoFocus
                    padding: 6
                    rightPadding: 6
                    scale: 0.7
                    anchors.right: parent.right
                    anchors.rightMargin: 0
                    autoExclusive: false
                    checked: true
                    anchors.verticalCenter: parent.verticalCenter
                    display: AbstractButton.IconOnly

                    Connections {
                        target: rectangle1_switch
                        // Toogle between Orbits visible and not visible
                        function onToggled() {
                            view.disableOrbits()
                        }
                    }
                }
            }

            Rectangle {
                id: rectangle2
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.top: rectangle1.bottom
                anchors.topMargin: 0
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: rectangle2_text
                    text: qsTr("Orbit Opacity")
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 12
                    anchors.fill: parent
                    anchors.leftMargin: 20
                }
            }

            Rectangle {
                id: rectangle3
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.top: rectangle2.bottom
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 0

                Slider {
                    id: opacitySlider
                    x: -28
                    y: 8
                    width: 240
                    height: 13
                    focusPolicy: Qt.NoFocus
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    scale: 0.7
                    value: 0.5
                    // Change the orbit opacity when the slider value is changed
                    onValueChanged: function(){
                        console.log(opacitySlider.value)
                        view.changeOrbitOpacity(opacitySlider.value)
                    }
                }
            }
        }

        DropDownMenu {
            id: menuCameras
            x: 0
            maxheight: 100
            rowHeight: 200
            clip: false
            maximized: false
            opacity: 1
            menuClip: true
            elementText: "Cameras"
            anchors.top: menuView.bottom
            anchors.topMargin: 2

            // Default Camera
            Rectangle {

                id: rectangle5
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.top: parent.top
                anchors.topMargin: 25
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: rectangle5_text
                    x: 20
                    y: 5
                    text: qsTr("Fixed Top View")
                    font.pixelSize: 12
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
            }

            // Angle View
            Rectangle {
                id: rectangle6
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 0
                anchors.topMargin: 0
                anchors.top: rectangle5.bottom

                Text {
                    id: rectangle6_text
                    x: 20
                    y: -25
                    text: qsTr("Fixed Angle View")
                    font.pixelSize: 12
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
            }

            Rectangle {
                id: rectangle8
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 0
                Text {
                    id: rectangle7_text1
                    x: 20
                    y: 5
                    text: qsTr("Free View")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle6.bottom
            }

            RadioButton {
                id: radioButton_topView
                x: 154
                y: 18
                text: qsTr("")
                focusPolicy: Qt.NoFocus
                anchors.verticalCenter: rectangle5.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                scale: 0.75
                display: AbstractButton.IconOnly
                // When this radio button is enabled, change to the default camera
                onCheckedChanged: function(){
                    view.planetCamera_handler("defaultCamera")
                    view.disableInfoButton()
                }

            }

            RadioButton {
                id: radioButton_angleView
                x: 154
                y: 45
                text: qsTr("")
                focusPolicy: Qt.NoFocus
                anchors.verticalCenter: rectangle6.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                scale: 0.75
                display: AbstractButton.IconOnly
                // When this radio button is enabled, change to the angled view camera
                onCheckedChanged: function() {
                    view.planetCamera_handler("angledView")
                }

            }

            RadioButton {
                id: radioButton_freeView
                x: 154
                y: 93
                text: qsTr("")
                checked: true
                focusPolicy: Qt.NoFocus
                anchors.verticalCenter: rectangle8.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                scale: 0.75
                display: AbstractButton.IconOnly
                // When this radio button is enabled, change to the freeview camera
                onCheckedChanged: view.planetCamera_handler("freeView")
            }
        }

        DropDownMenu {
            id: menuPresets
            x: 0
            y: 81
            maxheight: 75
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            clip: false
            menuClip: true
            elementText: "Presets"
            anchors.top: menuCameras.bottom
            anchors.topMargin: 2

            Button {
                id: button2
                width: 180
                height: 25
                //text: qsTr("Use standard Preset")
                font.pointSize: 9
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.topMargin: 25

                MouseArea {
                    id: button2_mouseArea
                    anchors.fill: parent
                    Connections {
                        target: button2_mouseArea
                        // When this button is pressed, change the planet positions and scaling to the default ones
                        function onClicked(){
                            setPreset_main_helper()
                        }

                    }
                }

                Text {
                    id: rectangle7_text2
                    x: 20
                    y: 5
                    text: qsTr("Use Standard Preset")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    anchors.leftMargin: 20
                }
            }

            Button {
                id: button3
                y: 55
                width: 180
                height: 25
                //text: qsTr("Create new Preset")
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: button2.top
                anchors.topMargin: 25

                MouseArea {
                    id: button3_mouseArea
                    anchors.fill: parent
                    // When this button is pressed, open the presets menu
                    onClicked: function () {
                        presetSelectMenu.visible = !presetSelectMenu.visible
                    }
                }

                Text {
                    id: rectangle7_text3
                    x: 20
                    y: 5
                    text: qsTr("Create Preset")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    anchors.leftMargin: 20
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.25}D{i:3;anchors_y:32}D{i:11;invisible:true}D{i:22;anchors_width:128;anchors_x:36;anchors_y:30}
D{i:26;anchors_width:128;anchors_x:36}
}
##^##*/
