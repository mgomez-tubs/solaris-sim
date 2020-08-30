import QtQuick 2.7
import QtQuick.Controls 2.0


Item {
    id: element
    width: 400
    height: 500

    Rectangle {
        id: rectangle1
        x: 180
        y: 207
        color: "#ffffff"
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        Rectangle {
            id: rectangle
            x: 0
            y: 0
            width: 400
            height: 27
            color: "#adf696"

            Text {
                id: element1
                x: 66
                y: 0
                text: qsTr("Edit Preset")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 12
            }
        }



        Item {
            id: element16
            width: 400
            height: 500





            Text {
                id: element2
                x: 8
                y: 33
                width: 107
                height: 20
                text: qsTr("Distance")
                font.family: "comic sans ms"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 12
            }

            Text {
                id: element3
                x: 285
                y: 33
                width: 107
                height: 20
                text: qsTr("Scaling")
                font.family: "Impact"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element4
                x: 147
                y: 60
                width: 107
                height: 20
                text: qsTr("Planet 1")
                font.family: "showcard gothic"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element5
                x: 147
                y: 95
                width: 107
                height: 20
                text: qsTr("Planet 2")
                font.family: "wide latin"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element6
                x: 147
                y: 165
                width: 107
                height: 20
                text: qsTr("Planet 4")
                font.family: "goudy stout"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element7
                x: 147
                y: 130
                width: 107
                height: 20
                text: qsTr("Planet 3")
                font.family: "forte"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element8
                x: 147
                y: 235
                width: 107
                height: 20
                text: qsTr("Planet 6")
                font.family: "berlin sans fb demi"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element9
                x: 147
                y: 270
                width: 107
                height: 20
                text: qsTr("Planet 7")
                font.family: "blackadder itc"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element10
                x: 147
                y: 200
                width: 107
                height: 20
                text: qsTr("Planet 5")
                font.family: "bernard mt condensed"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }

            Text {
                id: element11
                x: 147
                y: 375
                width: 107
                height: 20
                text: qsTr("Planet 10")
                font.family: "arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }


            Text {
                id: element12
                x: 147
                y: 340
                width: 107
                height: 20
                text: qsTr("Planet 9")
                font.family: "Arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }
            Text {
                id: element13
                x: 147
                y: 410
                width: 107
                height: 20
                text: qsTr("Planet 11")
                font.family: "arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }
            Text {
                id: element14
                x: 147
                y: 305
                width: 107
                height: 20
                text: qsTr("Planet 8")
                font.family: "arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }
            Text {
                id: element15
                x: 147
                y: 445
                width: 107
                height: 20
                text: qsTr("Planet 12")
                font.family: "arial"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 12
            }
        }
    }

    Rectangle {
        id: rectangle2
        x: 8
        y: 60
        width: 107
        height: 20
        color: "#bdbdbd"

        TextInput {
            id: textInput
            x: 0
            y: 0
            width: 107
            height: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput.text)
                // @disable-check M222
                getPlanet_helper(0)
                // @disable-check M222
                setParameter_helper(textInput.text, 0)
            }
        }
    }

    Rectangle {
        id: rectangle3
        x: 8
        y: 95
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput1
            x: 0
            y: -1
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 2")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput1.text)
                // @disable-check M222
                getPlanet_helper(1)
                // @disable-check M222
                setParameter_helper(textInput1.text, 0)}
        }
    }

    Rectangle {
        id: rectangle4
        x: 8
        y: 130
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput2
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 3")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput2.text)
                // @disable-check M222
                getPlanet_helper(2)
                // @disable-check M222
                setParameter_helper(textInput2.text, 0)}
        }
    }

    Rectangle {
        id: rectangle5
        x: 8
        y: 165
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput3
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 4")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput3.text)
                // @disable-check M222
                getPlanet_helper(3)
                // @disable-check M222
                setParameter_helper(textInput3.text, 0)}
        }
    }

    Rectangle {
        id: rectangle6
        x: 8
        y: 200
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput4
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 5")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput4.text)
                // @disable-check M222
                getPlanet_helper(4)
                // @disable-check M222
                setParameter_helper(textInput4.text, 0)}
        }
    }

    Rectangle {
        id: rectangle7
        x: 8
        y: 235
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput5
            x: 0
            y: -1
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 6")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput5.text)
                // @disable-check M222
                getPlanet_helper(5)
                // @disable-check M222
                setParameter_helper(textInput5.text, 0)}
        }
    }

    Rectangle {
        id: rectangle8
        x: 8
        y: 270
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput6
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 7")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput6.text)
                // @disable-check M222
                getPlanet_helper(6)
                // @disable-check M222
                setParameter_helper(textInput6.text, 0)}
        }
    }

    Rectangle {
        id: rectangle9
        x: 8
        y: 305
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput7
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 8")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput7.text)
                // @disable-check M222
                getPlanet_helper(7)
                // @disable-check M222
                setParameter_helper(textInput7.text, 0)}
        }
    }

    Rectangle {
        id: rectangle10
        x: 8
        y: 340
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput8
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 9")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput8.text)
                // @disable-check M222
                getPlanet_helper(8)
                // @disable-check M222
                setParameter_helper(textInput8.text, 0)}
        }
    }

    Rectangle {
        id: rectangle11
        x: 8
        y: 375
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput9
            x: 0
            y: -1
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 10")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput9.text)
                // @disable-check M222
                getPlanet_helper(9)
                // @disable-check M222
                setParameter_helper(textInput9.text, 0)}
        }
    }

    Rectangle {
        id: rectangle12
        x: 8
        y: 410
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput10
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 11")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput10.text)
                // @disable-check M222
                getPlanet_helper(10)
                // @disable-check M222
                setParameter_helper(textInput10.text, 0)}
        }
    }

    Rectangle {
        id: rectangle13
        x: 8
        y: 445
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput11
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Distance Planet 12")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator{bottom: 0; top: 5000;}
                focus: true
                color: acceptableInput ? "green" : "red"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput11.text)
                // @disable-check M222
                getPlanet_helper(11)
                // @disable-check M222
                setParameter_helper(textInput11.text, 0)}
        }
    }

    Rectangle {
        id: rectangle14
        x: 285
        y: 60
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput12
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 1")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput12.text)
                // @disable-check M222
                getPlanet_helper(0)
                // @disable-check M222
                setParameter_helper(textInput12.text, 1)}
        }
    }

    Rectangle {
        id: rectangle15
        x: 285
        y: 95
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput13
            x: 0
            y: -1
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 2")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput13.text)
                // @disable-check M222
                getPlanet_helper(1)
                // @disable-check M222
                setParameter_helper(textInput13.text, 1)}
        }
    }

    Rectangle {
        id: rectangle16
        x: 285
        y: 130
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput14
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 3")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput14.text)
                // @disable-check M222
                getPlanet_helper(2)
                // @disable-check M222
                setParameter_helper(textInput14.text, 1)}
        }
    }

    Rectangle {
        id: rectangle17
        x: 285
        y: 165
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput15
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 4")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput15.text)
                // @disable-check M222
                getPlanet_helper(3)
                // @disable-check M222
                setParameter_helper(textInput15.text, 1)}
        }
    }

    Rectangle {
        id: rectangle18
        x: 285
        y: 200
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput16
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 5")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput16.text)
                // @disable-check M222
                getPlanet_helper(4)
                // @disable-check M222
                setParameter_helper(textInput16.text, 1)}
        }
    }

    Rectangle {
        id: rectangle19
        x: 285
        y: 235
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput17
            x: 0
            y: -1
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 6")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput17.text)
                // @disable-check M222
                getPlanet_helper(5)
                // @disable-check M222
                setParameter_helper(textInput17.text, 1)}
        }
    }

    Rectangle {
        id: rectangle20
        x: 285
        y: 270
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput18
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 7")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput18.text)
                // @disable-check M222
                getPlanet_helper(6)
                // @disable-check M222
                setParameter_helper(textInput18.text, 1)}
        }
    }

    Rectangle {
        id: rectangle21
        x: 285
        y: 305
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput19
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 8")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput19.text)
                // @disable-check M222
                getPlanet_helper(7)
                // @disable-check M222
                setParameter_helper(textInput19.text, 1)}
        }
    }

    Rectangle {
        id: rectangle22
        x: 285
        y: 340
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput20
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 9")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput20.text)
                // @disable-check M222
                getPlanet_helper(8)
                // @disable-check M222
                setParameter_helper(textInput20.text, 1)}
        }
    }

    Rectangle {
        id: rectangle23
        x: 285
        y: 375
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput21
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 10")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput21.text)
                // @disable-check M222
                getPlanet_helper(9)
                // @disable-check M222
                setParameter_helper(textInput21.text, 1)}
        }
    }

    Rectangle {
        id: rectangle24
        x: 285
        y: 410
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput22
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 11")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput22.text)
                // @disable-check M222
                getPlanet_helper(10)
                // @disable-check M222
                setParameter_helper(textInput22.text, 1)}
        }
    }

    Rectangle {
        id: rectangle25
        x: 285
        y: 445
        width: 107
        height: 20
        color: "#bdbdbd"
        TextInput {
            id: textInput23
            x: 0
            y: 0
            width: 107
            height: 20
            //displayText: qsTr("Scaling Planet 12")
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            inputMask: "9.99"
            // @disable-check M223 // @disable-check M222
            onAccepted: {console.log(textInput23.text)
                // @disable-check M222
                getPlanet_helper(11)
                // @disable-check M222
                setParameter_helper(textInput23.text, 1)}
        }
    }
}
