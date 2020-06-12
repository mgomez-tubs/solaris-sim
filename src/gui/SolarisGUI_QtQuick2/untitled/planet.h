#ifndef PLANET_H
#define PLANET_H

#include "positionhandler.h"
#include <QDebug>

class Planet : public QObject
{
    Q_OBJECT
public:
    explicit Planet(QObject *rootObject, QString name, QString id);
    explicit Planet();
    QString name = "UNDEFINED";

    // A movement method for testing
    void circularRotation(float,float);        // This doesnt belong in here!!
    void setOrbitType(QString,float,float);
    PositionHandler positionHandler;

    void setProperties(QObject *,QString,QString);
    void setRootObject(QObject *);
    void setName(QString);
    void setId(QString);
    void setTimer(QTimer *);
    int order;
    void setOrder(int);
    QVector3D getCurrentPosition();
    QString getName();

    // Destructor
    ~Planet();

signals:
    void rowNameEmitter(QString value);

public slots:
    void debugMessage();

};

#endif // PLANET_H
