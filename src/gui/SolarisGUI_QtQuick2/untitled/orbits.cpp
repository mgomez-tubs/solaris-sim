#include <QVector3D>
#include <math.h>
#include "planet.h"

void Planet::kreisBewegung(){
    this->currentAngle+= M_PI_4*speed;
    this->position=QVector3D(radius*cos(currentAngle),radius*sin(currentAngle),0.0);
    QMetaObject::invokeMethod(planetHandler, "receive", Q_ARG(QVector3D, this->position));
}
