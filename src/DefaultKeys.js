function func(event) {
    switch(event.key){
    case Qt.Key_I:
        console.log("Rotated on the x axis");
        view.camera.parent.eulerRotation.x+=10; // I should document this...
        break;
    case Qt.Key_O:
        view.camera.parent.eulerRotation.x-=10;
        break;
    case Qt.Key_1:
        view.camera.position.x+=10;
        break;
    case Qt.Key_2:
        view.camera.position.x-=10;
        break;
    case Qt.Key_3:
        view.camera.position.y+=10;
        break;
    case Qt.Key_4:
        view.camera.position.y-=10;
        break;
    case Qt.Key_5:
        view.camera.position.z+=10;
        break;
    case Qt.Key_6:
        view.camera.position.z-=10;
        break;
    case Qt.Key_P:
        console.log("Current camera position: ["+view.camera.position.x+","+view.camera.position.y+","+view.camera.position.z+"]")
        console.log("Current camera rotation: ["+view.camera.parent.eulerRotation.x+","+view.camera.parent.eulerRotation.y+","+view.camera.parent.eulerRotation.z+"]")
        break;

}
}
