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
    static int numtest;
    QTimer * GLOBAL_TIMER;
    QTimer * DEBUG_TIMER;
    DebugWindow w;
    Planet Planeten [10];             // eventuell soll das dynamisch gemacht werden

    void addPlanet(QObject *,QString,QString);

    static int & anzahlPlaneten(){   // this method acts as a variable. to add a planet: anzahlPlaneten++, to see how many plaenets, anzahlplanete()
        static int counter = 0;
        return counter;
    }

    void addOnePlanet(){
        anzahlPlaneten()++;
    }

    void startTimer();
    void stopTimer();

private slots:
    void foo_slot();

};


#endif // SIMULATION_H
