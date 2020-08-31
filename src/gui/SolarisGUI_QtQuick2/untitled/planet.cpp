#include "planet.h"
#include <QVariant>

// ++++                     Static declarations                             ++++ //
float Planet::speedMultiplier = 1.0;


// ++++                     Constructor                                     ++++ //

/*!
 *  \brief Constructor for planet object.
 */
Planet::Planet(){
    this->radius = 0.0;
    this->radius2 = 0.0;
}

// ++++                     Setters                                     ++++ //
/*!
 *  \brief Set planet name
 */
void Planet::setName(QString name){
    this->name = name;
}

/*!
 *  \brief Reset planet position to angle 0.0
 */
void Planet::resetPosition(){
    this->currentAngle = 0.0;
    QMetaObject::invokeMethod(planetHandler, "receive", Q_ARG(QVector3D, this->defaultPosition), Q_ARG(double, this->currentAngle));
}

/*!
 *  \brief Set planet order number
 */
void Planet::setOrder(int order){
    this->order=order;
}

/*!
 *  \brief Set planet properties
 *  \param rootObject - For interaction with QML, a pointer to the QML root object has to be
 * passed as a pointer.
 * \param name - The name of the planet
 * \param objectName - The QML id of the planet, corresponds to the attribute objectName in QML
 */
void Planet::setProperties(QObject *rootObject, QString name, QString objectName){
    this->name          = name;
    this->rootObject    = rootObject;
    this->planetHandler = rootObject->findChild<QObject*>(objectName);
    #ifdef DEBUG_IS_ENABLED
    // Bilde Zeilen für das Debug Menu
    emit rowNameEmitter(this->name);
    #endif
}

/*!
 *  \brief Set planet scaling
 * \param vector - Vector for the scaling in the x , y and z coordinates.
 */
void Planet::setScaling(QVector3D vector){
    this -> scale = vector;
     QMetaObject::invokeMethod(planetHandler, "receiveScale", Q_ARG(QVector3D, this->scale ));
}

/*!
 *  \brief Set planet properties through preset
 */
void setPreset_main(){
    //int distance_mercury = 40, distance_venus = 70, distance_earth = 100, distance_mars = 150, distance_jupiter = 320, distance_saturn = 560, distance_uranus = 820, distance_neptun = 1000;
    //int planet_distance[8] = {40,70,100,150,320,560,820,1000};
    //console.log("test")
}

/*!
 *  \brief Save presets
 */
void savePreset(){
}

/*!
 *  \brief Set planet orbit type
 *  \param type - The name of the rotation assigned for this planet
 *  \param speed - The angular speed for this planet
 */
void Planet::setOrbitType(QString type, float radius, float speed){
    if(type == "kreisBewegung"){
        this->radius =radius;

        // Add this Orbit to QML Orbit list
        QObject * viewHandler = rootObject->findChild<QObject*>("view");
        QMetaObject::invokeMethod(viewHandler, "receiveOrbit", Q_ARG(double, this->radius));

        this->speed = speed;
        this->currentAngle = 0.0;
        this->position = QVector3D(radius,0.0,0.0);
        this->defaultPosition = QVector3D(radius,0.0,0.0);
    }else{
        qDebug()<<"Error setting orbit type. Typo?";
    }
}

/*!
 *  \brief Set planet radius
 */
void Planet::setRadius(){
    qDebug()<<"is this used????";
    QMetaObject::invokeMethod(planetHandler, "setRadiusKreisBahn", Q_ARG(qreal, this->radius));
}

/*!
 *  \brief Set planet tilt angle (only for Uranus)
 */
void Planet::setTiltAngle(float angle){
    this->tiltAngle = angle;
}

/*!
 *  \brief Set information string, text will be parsed as HTML
 */
void Planet::setInfoTextHTML(QString str){
    this->infoTextHTML = str;
    QMetaObject::invokeMethod(planetHandler, "receiveInfoString", Q_ARG(QString, str));
}

// ++++                     Getters                        ++++ //
/*!
 *  \brief Get planet name
 */
QString Planet::getName(){
    return this->name;
}

/*!
 *  \brief Get planet default position
 */
QVector3D Planet::getDefaultPosition(){
    return this->defaultPosition;
}

/*!
 *  \brief Get planet QML handler
 */
QObject * Planet::getPlanetHandler(){
    return this->planetHandler;
}

/*!
 *  \brief Get planet tilt Angle
 */
float Planet::getTiltAngle(){
    return this->tiltAngle;
}

// ++++                     Signals                             ++++ //
void Planet::positionEmitter_helper(){
    emit positionEmitter(this->order,position, this->currentAngle);
}
// ++++                     Destructor                             ++++ //
Planet::~Planet(){
    qDebug()<<this->name << "was destroyed.";
}

