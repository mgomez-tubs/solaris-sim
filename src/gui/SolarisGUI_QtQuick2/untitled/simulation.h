#ifndef SIMULATION_H
#define SIMULATION_H

#include <QTimer>
#include "planet.h"
#include "debugwindow.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

// External libraries

class Simulation : public QObject
{
    Q_OBJECT
public:
    //int distance_mercury;
    int planet_distance[13];
    double planet_scaling[13];
    float distanceScale;
    int planet_tmp;

    Simulation(QObject*);
    QTimer * SIMULATION_TIMER;
    QTimer * DEBUG_TIMER;
    QObject * rootObject;
    DebugWindow w;
    Planet Planeten [10];             // eventuell soll das dynamisch gemacht werden
    Planet ZwergPlaneten[10];

    bool simulTimerRunning = false;

    void addPlanet(QObject*,QString,QString);
    void addZwergPlanet(QObject*,QString,QString);

    static int & anzahlPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplaneten()
        static int counterP = 0;
        return counterP;
    }

    static int & anzahlZwergPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplaneten()
        static int counterZP = 0;
        return counterZP;
    }

    void addOnePlanet(){
        anzahlPlaneten()++;
    }

    void addOneZwergPlanet(){
        anzahlZwergPlaneten()++;
    }



    void startTimer();
    void stopTimer();

    // Simulation flow
    void Init();
    void Run();

    // Handler
    QString getPlanetInfoString(int planetID);
    QVector<float> getPlanetOrbitInfo(int planetID);

private slots:
    void getPlanet(qreal);
    void getPath(QString);
    double setParameter(qreal);
    void write(QJsonObject &json) const;
    void read(const QJsonObject &json);
    void tooglePlayPause();
    void Reset();
    void setSpeedMultiplier(qreal);
    void savePreset();
    void setPreset_main();
};


#endif // SIMULATION_H
