#include "planet.h"
#include "positionhandler.h"
#include <QDebug>

Planet::Planet(QObject *rootObject, QString name, QString id) : QObject()
{
    // Object properties
    this->name  = name;
    this->positionHandler.setqmlId(id);

    // Movement related properties
    // Pass the QML rootObject pointer to the positionHandler
    this->positionHandler.setqmlObject(rootObject);
}

void Planet::setOrbitType(QString type, float radius, float speed){
    if(type == "cRotation"){
        this->positionHandler.circularRotation(radius, speed);
        qDebug()<<"Set circular rotation for"<<this->name;
    }else{
        qDebug()<<"Error setting orbit type.";
    }
}
