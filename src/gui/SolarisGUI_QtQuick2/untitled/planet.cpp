#include "planet.h"
#include <QVariant>



////          static declarations   ////
float Planet::speedMultiplier = 1.0;


////          CONSTRUCTOR           ////
Planet::Planet(){
}

////          SETTERS               ////
void Planet::setName(QString name){
    this->name = name;
}

void Planet::resetPosition(){
    // Reset circular rotation angle
    this->currentAngle = 0.0;
    QMetaObject::invokeMethod(planetHandler, "receive", Q_ARG(QVector3D, this->defaultPosition), Q_ARG(double, this->currentAngle));
}

void Planet::setOrder(int order){
    this->order=order;
}

void Planet::setProperties(QObject *rootObject, QString name, QString objectName){
    this->name          = name;
    this->rootObject    = rootObject;
    this->planetHandler = rootObject->findChild<QObject*>(objectName);
    #ifdef DEBUG_IS_ENABLED
    // Bilde Zeilen für das Debug Menu
    emit rowNameEmitter(this->name);
    #endif
}

void Planet::setOrbitType(QString type, float radius, float speed){
    if(type == "kreisBewegung"){
        this->radius =radius;
        this->speed = speed;
        this->currentAngle = 0.0;
        this->position = QVector3D(radius,0.0,0.0);
        this->defaultPosition = QVector3D(radius,0.0,0.0);
        // setRadius(); // change to addRadius()
        qDebug()<<"Circular rotation was set for"<<this->name;
    }else{
        qDebug()<<"Error setting orbit type. Typo?";
    }
}

void Planet::setRadius(){
    QMetaObject::invokeMethod(planetHandler, "setRadiusKreisBahn", Q_ARG(qreal, this->radius));
}

////          GETTERS               ////
QString Planet::getName(){
    return this->name;
}

QVector3D Planet::getDefaultPosition(){
    return this->defaultPosition;
}

QObject * Planet::getPlanetHandler(){
    return this->planetHandler;
}

////          SIGNALS               ////
void Planet::positionEmitter_helper(){
    emit positionEmitter(this->order,position, this->currentAngle);
}
////          DESTRUCTOR           ////
Planet::~Planet(){
    qDebug()<<this->name << "was destroyed.";
}

