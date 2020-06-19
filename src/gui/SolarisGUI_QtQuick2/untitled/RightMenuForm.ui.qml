import QtQuick 2.4
import QtQuick.Controls 2.12

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
            anchors.topMargin: 2
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
            id: dropDownMenu
            x: 0
            elementText: "Cameras"
            anchors.top: menuView.bottom
            anchors.topMargin: 2
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:2;height:450;width:200}D{i:2;anchors_y:23}D{i:5;anchors_x:47;anchors_y:8}
D{i:9;anchors_x:47;anchors_y:8}D{i:8;anchors_y:63}D{i:10;anchors_y:63}D{i:3;anchors_y:66}
D{i:1;anchors_height:200;anchors_width:200;anchors_x:14;anchors_y:112}
}
##^##*/

