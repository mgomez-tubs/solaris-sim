#ifndef PLANET_H
#define PLANET_H

#include <QObject>
#include "positionhandler.h"

class Planet : public QObject
{
    Q_OBJECT

public:
    explicit Planet(QObject *rootObject, QString name, QString id);
    QString name;

    // A movement method for testing
    void circularRotation(float radius, float speed);

private:
    PositionHandler positionHandler;

signals:

};

#endif // PLANET_H
