function func(event) {
    switch(event.key){
    case Qt.Key_I:
        console.log("Rotated on the x axis");
        view.camera.parent.eulerRotation.x+=10; // I should document this...
        break;
    case Qt.Key_O:
        view.camera.parent.eulerRotation.x-=10;
        break;
    case Qt.Key_K:
        view.camera.y+=10;
        break;
    case Qt.Key_L:
        view.camera.y-=10;
        break;
    case Qt.Key_N:
        view.camera.z+=10;
        break;
    case Qt.Key_M:
        view.camera.z-=10;
        break;
}
}
