#include "positionhandler.h"
#include <QTimer>
#include <QDebug>
#include <QQmlProperty>
#include <QMetaObject>
#include <math.h>

PositionHandler::PositionHandler():QObject(){

}


void PositionHandler::circularRotation(float radius, float speed) {
    if(moving == false){
        // Set Radius to input Wert
        this->radius    = radius;
        this->speed     = speed;

        // Connect QTimer to position updater
        connect(timer, SIGNAL(timeout()), this, SLOT(updatePosition()));

        // Set up QTimer
        timer->start(msintervall);

        // set moving flag to true
        moving = true;
        qDebug()<<"Animation started for"<<this->id;

        // set initial position
        //qDebug()<<radius;
        pos = QVector3D(radius,0.0,0.0);

        // set initial angle
        currentAngle=0.0;

        // update first frame
        setPosition(pos);
    }
}

void PositionHandler::setPosition(QVector3D vector){

    // Send Vector3D object to receiver, which will update the position
    // of the planet in real time.
    QMetaObject::invokeMethod(erdeHandler, "receive", Q_ARG(QVector3D, vector));

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
    erdeHandler = qmlObject_ptr->findChild<QObject*>(id);
}

void PositionHandler::setqmlId(QString id){
    this->id = id;
}


