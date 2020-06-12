#include "planet.h"


Planet::Planet(){

}

Planet::Planet(QObject *rootObject, QString name, QString id) : QObject()
{
    // Set object properties
    this->name  = name;
    this->positionHandler.setqmlId(id);

    // Movement related properties
    // Pass the QML rootObject pointer to the positionHandler
    this->positionHandler.setqmlObject(rootObject);

}

void Planet::setRootObject(QObject * rootObject){
    this->positionHandler.setqmlObject(rootObject);
}

void Planet::setName(QString name){
    this->name = name;

}
void Planet::setId(QString id){
    this->positionHandler.setqmlId(id);
}

void Planet::setOrbitType(QString type, float radius, float speed){
    if(type == "cRotation"){
        this->positionHandler.circularRotation(radius, speed);
        qDebug()<<"Set circular rotation for"<<this->name;
    }else{
        qDebug()<<"Error setting orbit type.";
    }
}

void Planet::debugMessage(){
    qDebug()<<"DEBUG";
}

void Planet::setProperties(QObject *rootObject, QString name, QString id){

    this->name  = name;
    this->positionHandler.setqmlId(id);
    this->positionHandler.setqmlObject(rootObject);
    this->positionHandler.setOrder(this->order);
    #ifdef DEBUG_IS_ENABLED
    // Bilde Zeilen für das Debug Menu
    emit rowNameEmitter(this->name);
    #endif
}

void Planet::setOrder(int order){
    this->order=order;
}

void Planet::setTimer(QTimer * timer){      // this is the one
    this->positionHandler.timer=timer;
}

QString Planet::getName(){
    return this->name;
}

QVector3D Planet::getCurrentPosition(){
    return this->positionHandler.pos;
}
Planet::~Planet(){
    qDebug()<<this->name << "was destroyed.";
}
