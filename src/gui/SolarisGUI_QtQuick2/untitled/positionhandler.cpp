#include "positionhandler.h"
#include <QTimer>
#include <QDebug>
#include <QQmlProperty>
#include <QMetaObject>
#include <math.h>

// static declarations

PositionHandler::PositionHandler(){
}

void PositionHandler::circularRotation(float radius, float speed) {
    if(moving == false){
        // Set Radius to input Wert
        this->radius    = radius;
        this->speed     = speed;

        // Connect QTimer to position updater
        connect(timer, SIGNAL(timeout()), this, SLOT(updatePosition()));

        // Start Timer
        this->timer->start(16);

        // Set moving flag to true
        moving = true;
        qDebug()<<"Animation started for"<<this->id;

        // Set initial position
        pos = QVector3D(radius,0.0,0.0);

        // Set initial angle
        currentAngle=0.0;

        // Update first frame
        setPosition(pos);
    }
}

void PositionHandler::setPosition(QVector3D vector){

    // Send Vector3D object to receiver, which will update the position
    // of the planet in real time.
    QMetaObject::invokeMethod(planetHandler, "receive", Q_ARG(QVector3D, vector));
}

void PositionHandler::updatePosition(){
    // update current angle
    // for every tick, planet angular position advances PI/4  * speed
    currentAngle+= M_PI_4*this->speed;

    // update current position
    pos=QVector3D(radius*cos(currentAngle),radius*sin(currentAngle),0.0);

    // change planet properties
    setPosition(pos);
}

void PositionHandler::setqmlObject(QObject* ptr){
    this->qmlObject_ptr=ptr;
    // Create a handler to the planet properties from created QML Pointer
    planetHandler = qmlObject_ptr->findChild<QObject*>(id);
}

void PositionHandler::setqmlId(QString id){
    this->id = id;
}

void PositionHandler::updateDebugData(){
}

void PositionHandler::positionEmitter_helper(){
    emit positionEmitter(this->order,pos); // change zero with order number
}

void PositionHandler::setOrder(int order){
    this->order=order;
}
