#include "simulation.h"
#include <QDebug>

Simulation::Simulation(QObject * rootObject)
{
    this->GLOBAL_TIMER = new QTimer(this);
    this->DEBUG_TIMER = new QTimer(this);

    addPlanet(rootObject,"Merkur","merkur");    // find a way to dynamically create objects
    addPlanet(rootObject,"Venus","venus");
    addPlanet(rootObject,"Erde","erde");
    addPlanet(rootObject,"Mars","mars");

    Planeten[0].setOrbitType("cRotation", 100.0, .0015);
    Planeten[1].setOrbitType("cRotation", 200.0, .0045);
    Planeten[2].setOrbitType("cRotation", 300.0, .0155);
    Planeten[3].setOrbitType("cRotation", 400.0, .0025);

#ifdef DEBUG_IS_ENABLED
    // Display DEBUG window
    this->w.show();
#endif

    // Closing the main window will close the whole Application
    connect(rootObject, SIGNAL(mainWclosed()),
            qApp, SLOT(quit()));

    startTimer();
}

void Simulation::addPlanet(QObject * rootObject, QString name, QString id){
    // Set timer
    Planeten[anzahlPlaneten()].setTimer(this->GLOBAL_TIMER);

    // Connections
#ifdef DEBUG_IS_ENABLED
    connect(&Planeten[anzahlPlaneten()], &Planet::rowNameEmitter,&w,&DebugWindow::addRow);
    connect(DEBUG_TIMER, &QTimer::timeout, &Planeten[anzahlPlaneten()].positionHandler, &PositionHandler::positionEmitter_helper);
    connect(&Planeten[anzahlPlaneten()].positionHandler, &PositionHandler::positionEmitter,&w,&DebugWindow::setTableValues);

    // GUI connections
    connect(&w,&DebugWindow::resumeSimulation,this,&Simulation::startTimer);
    connect(&w,&DebugWindow::stopSimulation,this,&Simulation::stopTimer);

#endif
    // Planeten bilden
    Planeten[anzahlPlaneten()].setOrder(anzahlPlaneten());
    Planeten[anzahlPlaneten()].setProperties(rootObject,name,id);

    // Up the planet counter
    this->addOnePlanet();
}

void Simulation::startTimer(){
    // Start global timer
    GLOBAL_TIMER->start(16);
    // Start debug timer
    DEBUG_TIMER->start(250);
}

void Simulation::stopTimer(){
    GLOBAL_TIMER->stop();
    DEBUG_TIMER->stop();
}

void Simulation::foo_slot()
{
}
