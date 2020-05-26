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

// Different planet movements can be called from this class methods
void Planet::circularRotation(float radius, float speed){
    this->positionHandler.circularRotation(radius, speed);
}
