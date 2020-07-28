#ifndef SIMULATION_H
#define SIMULATION_H

#include <QTimer>
#include "planet.h"
#include "debugwindow.h"

class Simulation : public QObject
{
    Q_OBJECT
public:
    Simulation(QObject*);
    QTimer * SIMULATION_TIMER;
    QTimer * DEBUG_TIMER;
    QObject * rootObject;
    DebugWindow w;
    Planet Planeten [10];             // eventuell soll das dynamisch gemacht werden
    bool simulTimerRunning = false;

    void addPlanet(QObject*,QString,QString);

    static int & anzahlPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplaneten()
        static int counter = 0;
        return counter;
    }

    void addOnePlanet(){
        anzahlPlaneten()++;
    }

    void startTimer();
    void stopTimer();

    // Simulation flow
    void Init();
    void Run();


private slots:
    void tooglePlayPause();
    void Reset();
    void setSpeedMultiplier(qreal);
    //void setPreset_main();
};


#endif // SIMULATION_H
