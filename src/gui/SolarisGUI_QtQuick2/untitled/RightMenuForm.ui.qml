import QtQuick 2.4
import QtQuick.Controls 2.15

Item {
    width: 200
    height: 500

    Rectangle {
        id: rectangle
        color: "#3f0641"
        anchors.fill: parent

        DropDownMenu {
            id: menuGeneral
            x: 0
            menuClip: true
            clip: false
            elementText: "General"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        DropDownMenu {
            id: menuView
            x: 8
            maximized: false
            menuClip: true
            clip: false
            elementText: "View"
            anchors.top: menuGeneral.bottom
            anchors.topMargin: 2
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: rectangle1
                x: 0
                y: 32
                width: 200
                height: 25
                color: "#c6cecf"
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
                        // @disable-check M222
                        onToggled: function () {
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
                    text: qsTr("Orbit Opacity (coming...)")
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
                    id: rectangle3_slider
                    x: -28
                    y: 8
                    width: 240
                    height: 13
                    focusPolicy: Qt.NoFocus
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    scale: 0.7
                    value: 0.5
                }
            }
        }

        DropDownMenu {
            id: menuCameras
            x: 0
            clip: false
            maximized: false
            opacity: 1
            menuClip: true
            elementText: "Cameras"
            anchors.top: menuView.bottom
            anchors.topMargin: 2

            Rectangle {
                // Default Camera
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
                    text: qsTr("Top View")
                    font.pixelSize: 12
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
/*
                MouseArea {
                    id: rectangle5_mouseArea
                    anchors.fill: parent
                    // @disable-check M222
                    onClicked: view.planetCamera_handler("defaultCamera")
                }*/
            }

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
                    text: qsTr("Angle View")
                    font.pixelSize: 12
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
            }

            Rectangle {
                // Planet View
                id: rectangle7
                x: 0
                width: 200
                height: 25
                color: "#c6cecf"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 0
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle6.bottom

                Text {
                    id: rectangle7_text
                    x: 20
                    y: 5
                    text: qsTr("Planet View 1 (Erde)")
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
                    text: qsTr("FreeView")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 20
                }
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle7.bottom
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
                // @disable-check M222
                onCheckedChanged: view.planetCamera_handler("defaultCamera")
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
                // @disable-check M222
                onCheckedChanged: view.planetCamera_handler("angledView")
            }

            RadioButton {
                id: radioButton_planetView
                x: 154
                y: 68
                text: qsTr("")
                focusPolicy: Qt.NoFocus
                anchors.verticalCenter: rectangle7.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 5
                scale: 0.75
                display: AbstractButton.IconOnly
                // @disable-check M222
                onCheckedChanged: view.planetCamera_handler("erde")
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
                // @disable-check M222
                onCheckedChanged: view.planetCamera_handler("freeView")
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.75}D{i:15;anchors_height:100;anchors_width:100;anchors_x:0;anchors_y:"-25"}
D{i:18;anchors_height:100;anchors_width:100}
}
##^##*/

