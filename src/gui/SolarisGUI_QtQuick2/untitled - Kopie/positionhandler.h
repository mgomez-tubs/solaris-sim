#ifndef ROTATIONHANDLER_H
#define ROTATIONHANDLER_H

#include <QObject>
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
    void circularRotation(float radius, float speed);

private:

    // Create a QTimer Object to handle rate of value transmittion
    QTimer *timer = new QTimer(this);

    // Vector properties
    QVector3D pos;
    float currentAngle=0.0;
    float radius = 300;
    QString id;

    // Animation properties
    bool moving = false;
    float speed = 0.25;

    float msintervall = 250;       // Send a new value every 250 ms
                                   // This intervall should be syncronized between QML and Backend
                                   // so the movement smoothing works properly
    QObject *qmlObject_ptr;
    QObject *erdeHandler;


private slots:
    void updateFrame();

public slots:

};

#endif // ROTATIONHANDLER_H
