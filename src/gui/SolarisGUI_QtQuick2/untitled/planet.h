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

    // static vars
    static float speedMultiplier;

    // Available orbit methods
    void move1();
    void kreisBewegung();

    // Properties for all types of movement
    int order;
    QVector3D position;
    QObject * rootObject;
    QString id;
    QObject *planetHandler;
    QVector3D defaultPosition;
    float tiltAngle = 0.0;
    QVector3D scale;

    // Move 1 specific properties
    float currentAngle;
    float radius;
    float speed;

    // Structs
    // Data for the calculation of the planets orbit
    struct orbitDatastr {
        float p = 0.0;                                       // Bahnperiode in [a]
        float l_ha = 0.0;                                    // Große halbachse in [m]
        float ex = 0.0;                                      // Exzentrizität
        float v_mo = 0.0;                                    // mittlere Orbital geschwindigkeit in [m/s]
        float d_aeq = 0.0;                                   // aequatordurchmesser in [m]
        float d_pol = 0.0;                                   // poldurchmesser in [m]
        float m = 0.0;                                       // masse in [kg]
        float dichte = 0.0;                                  // dichte in [g/cm^3]
        float l_m = 0.0;                                     // mittlere entfernung zur sonne in [m]
    }orDt;

    // Text data to display on planet clicked
    struct infoTextStr {
        QString title;
        QString data;
        QString info;
        QString explo;
    }planetInfo;

    QString infoTextHTML;

    // Adders

    // Setters
    void setPreset_main();
    void setOrbitType(QString,float,float);
    void setProperties(QObject *,QString,QString);
    void setScaling(QVector3D);
    void setName(QString);
    void resetPosition();
    void setId(QString);
    void setOrder(int);
    void setRadius();
    void setTiltAngle(float);

    // Getters
    QString getName();
    QVector3D getDefaultPosition();
    QObject * getPlanetHandler();
    float getTiltAngle();

    // Destructor
    ~Planet();

signals:
    void rowNameEmitter(QString value);
    void positionEmitter(int, QVector3D,float);

public slots:
    void positionEmitter_helper();
};

#endif // PLANET_H
