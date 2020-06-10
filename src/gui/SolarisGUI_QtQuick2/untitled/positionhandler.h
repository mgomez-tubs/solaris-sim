#ifndef ROTATIONHANDLER_H
#define ROTATIONHANDLER_H

#include <QVector3D>
#include <QTimer>

class PositionHandler : public QObject
{
    Q_OBJECT
public:
    explicit PositionHandler();
    void setPosition(QVector3D);
    void setqmlObject(QObject*);
    void setqmlId(QString);
    void setTimer(QTimer*);
    void circularRotation(float radius, float speed);

    QTimer *timer;

    // Vector properties
    QVector3D pos;

private:

    float currentAngle=0.0;
    float radius = 300;
    QString id;

    // Animation properties
    bool moving = false;
    float speed = 0.25;
    int order;

    float msintervall = 16;       // Send a new value every 250 ms
                                   // This intervall should be syncronized between QML and Backend
                                   // so the movement smoothing works properly
    QObject *qmlObject_ptr;
    QObject *planetHandler;

public:
    void setOrder(int);

public slots:
    void updatePosition();
    void updateDebugData();
    void positionEmitter_helper();

signals:
    void positionEmitter(int, QVector3D vector);
};

#endif // ROTATIONHANDLER_H
