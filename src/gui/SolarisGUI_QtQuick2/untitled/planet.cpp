#include "planet.h"

////          CONSTRUCTOR           ////
Planet::Planet(){
}

////          SETTERS               ////
void Planet::setName(QString name){
    this->name = name;
}

void Planet::setId(QString id){
    this->id=id;
    qDebug()<<"For Planet"<<name<<"the id"<<this->id<<"was set";
}

void Planet::setOrder(int order){
    this->order=order;
}

void Planet::setProperties(QObject *rootObject, QString name, QString id){
    this->name          = name;
    this->rootObject    = rootObject;
    this->planetHandler = rootObject->findChild<QObject*>(id);
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
        qDebug()<<"Circular rotation was set for"<<this->name;
    }else{
        qDebug()<<"Error setting orbit type.";
    }
}

////          GETTERS               ////
QString Planet::getName(){
    return this->name;
}

////          SIGNALS               ////
void Planet::positionEmitter_helper(){
    emit positionEmitter(this->order,position);
}

////          DESTRUCTOR           ////
Planet::~Planet(){
    qDebug()<<this->name << "was destroyed.";
}

