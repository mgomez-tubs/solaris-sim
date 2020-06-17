#ifndef PLANET_H
#define PLANET_H

#include <QDebug>
#include <QVector3D>
#include "math.h"

class Planet : public QObject
{
    Q_OBJECT
public:
    explicit Planet();
    QString name = "UNDEFINED";     // Default name for not created planets.

    // Available orbit methods
    void move1();
    void kreisBewegung();

    // Properties for all types of movement
    int order;
    QVector3D position;
    QObject * rootObject;
    QString id;
    QObject *planetHandler;

    // Move 1 specific properties
    float currentAngle;
    float radius;
    float speed;

    // Setters
    void setOrbitType(QString,float,float);
    void setProperties(QObject *,QString,QString);
    void setName(QString);
    void setId(QString);
    void setOrder(int);

    // Getters
    QString getName();

    // Destructor
    ~Planet();

signals:
    void rowNameEmitter(QString value);
    void positionEmitter(int, QVector3D,float);

public slots:
    void positionEmitter_helper();
};

#endif // PLANET_H
