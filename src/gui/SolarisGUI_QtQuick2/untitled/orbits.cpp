#include <QVector3D>
#include <math.h>
#include "planet.h"

/*!
 *    \brief Function for handling the planet rotation. This is called periodically by QTimer.
 */
void Planet::kreisBewegung(){
    if(this->currentAngle>M_PI * 2){
        this->currentAngle-=M_PI*2;
    }
    this->currentAngle+= M_PI_4*speed*speedMultiplier;
    this->position=QVector3D(radius*cos(currentAngle),radius*sin(currentAngle),0.0);
    // Send the position and angle to QML
    QMetaObject::invokeMethod(planetHandler, "receive", Q_ARG(QVector3D, this->position), Q_ARG(double, this->currentAngle));
}
