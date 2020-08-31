#ifndef SIMULATION_H
#define SIMULATION_H

#include <QTimer>
#include "planet.h"
#include "debugwindow.h"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

class Simulation : public QObject
{
    Q_OBJECT
public:

    // ++++                     Constructor                           ++++ //

    Simulation(QObject*);

    // ++++                     Object members                        ++++ //

    // Simulation Timers
    QTimer * SIMULATION_TIMER;
    QTimer * DEBUG_TIMER;
    bool simulTimerRunning = false;

    // QML Root Object
    QObject * rootObject;

    // Debug Window
    DebugWindow w;

    // Arrays for Planets and Small planets
    Planet Planeten [10];
    Planet ZwergPlaneten[10];
    void addPlanet(QObject*,QString,QString);
    void addZwergPlanet(QObject*,QString,QString);

    // Counter for number of planets
    static int & anzahlPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplaneten()
        static int counterP = 0;
        return counterP;
    }

    // Counter for number of small planet
    static int & anzahlZwergPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplaneten()
        static int counterZP = 0;
        return counterZP;
    }

    // Preset control
    //int distance_mercury;
    int planet_distance[13];
    double planet_scaling[13];
    float distanceScale;
    int planet_tmp;

    // ++++                     Object functions                        ++++ //
    // Add one planet to the list
    void addOnePlanet(){
        anzahlPlaneten()++;
    }

    // Add one small planet to the list
    void addOneZwergPlanet(){
        anzahlZwergPlaneten()++;
    }

    // Timer control
    void startTimer();
    void stopTimer();

    // Simulation flow
    void Init();
    void Run();

    // ++++                     Getters
    QString getPlanetInfoString(int planetID);
    QVector<float> getPlanetOrbitInfo(int planetID);

private slots:
    void getPlanet(qreal);
    void setParameter(qreal, qreal);
    void tooglePlayPause();
    void Reset();
    void setSpeedMultiplier(qreal);
    void setPreset_main();
};


#endif // SIMULATION_H
