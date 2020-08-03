#include "planet.h"
#include <QVariant>




////          STATIC DECLARATIONS           ////
float Planet::speedMultiplier = 1.0;


////          CONSTRUCTOR                   ////
Planet::Planet(){
}

////          SETTERS                       ////
void Planet::setName(QString name){
    this->name = name;
}

void Planet::resetPosition(){
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

void Planet::setScaling(QVector3D vector){
    this -> scale = vector;
     QMetaObject::invokeMethod(planetHandler, "receiveScale", Q_ARG(QVector3D, this->scale ));
}
void setPreset_main(){
    int distance_mercury = 40, distance_venus = 70, distance_earth = 100, distance_mars = 150, distance_jupiter = 320, distance_saturn = 560, distance_uranus = 820, distance_neptun = 1000;
    int planet_distance[8] = {40,70,100,150,320,560,820,1000};
    //console.log("test")
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

