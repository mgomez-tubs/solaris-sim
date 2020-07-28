#include "simulation.h"
#include <QDebug>

Simulation::Simulation(QObject * rootObject)
{
    // Set root object
    this->rootObject = rootObject;

    // Set timers
    this->SIMULATION_TIMER = new QTimer(this);
    this->DEBUG_TIMER = new QTimer(this);

    #ifdef DEBUG_IS_ENABLED
        // Display DEBUG window
        this->w.show();
    #endif

    // Closing the main window should close the whole Application

    connect(rootObject, SIGNAL(mainWclosed()),
            qApp, SLOT(quit()));
    startTimer();

    // Initialize planets
    this->Init();
}

void Simulation::addPlanet(QObject * rootObject, QString name, QString id){
    // Connections
#ifdef DEBUG_IS_ENABLED
    // Beim Erstellen eines neues Planets eine neue Zeile in DEBUG WINDOW hinzufügen
    connect(&Planeten[anzahlPlaneten()], &Planet::rowNameEmitter,&w,&DebugWindow::addRow);

    // Bei jedem timeout von DEBUG_TIMER rufe die Methode positionEmitter_helper auf
    connect(DEBUG_TIMER, &QTimer::timeout, &Planeten[anzahlPlaneten()], &Planet::positionEmitter_helper);

    // Wenn positionEmitter_helper aufgerufen wird, aktualisiere die Daten in der Tabelle
    // This method seems redundant but its not and its of common usage.
    connect(&Planeten[anzahlPlaneten()], &Planet::positionEmitter, &w, &DebugWindow::setTableValues);

    // GUI connections
    // BUTTONS
    connect(&w,&DebugWindow::resumeSimulation,this,&Simulation::startTimer);
    connect(&w,&DebugWindow::stopSimulation,this,&Simulation::stopTimer);

#endif

    // Eigenschaften
    // Order Number
    Planeten[anzahlPlaneten()].setOrder(anzahlPlaneten());
    // Set Properties
    Planeten[anzahlPlaneten()].setProperties(rootObject,name,id);

    // Up the planet counter
    this->addOnePlanet();
}

// Simulation flow
void Simulation::Init(){

    // Set Up QML Connections
    connect(rootObject,SIGNAL(tooglePlayPause()),   this,SLOT(tooglePlayPause()));
    connect(rootObject,SIGNAL(resetSimulation()),   this,SLOT(Reset()));
    connect(rootObject,SIGNAL(setSpeedMultiplier(qreal)), this,SLOT(setSpeedMultiplier(qreal)));
    connect(rootObject,SIGNAL(setPreset_main()), this,SLOT(setPreset_main));

    addPlanet(rootObject,"Merkur","merkur");    //0
    addPlanet(rootObject,"Venus","venus");      //1
    addPlanet(rootObject,"Erde","erde");        //2
    addPlanet(rootObject,"Mars","mars");        //3
    addPlanet(rootObject,"Jupiter","jupiter");  //4
    addPlanet(rootObject,"Saturn", "saturn");   //5
    addPlanet(rootObject,"Uranus","uranus");    //6
    addPlanet(rootObject,"Neptun", "neptun");   //7

    float distanceScale = 3;

    int distance_mercury = 40, distance_venus = 70, distance_earth = 100, distance_mars = 150, distance_jupiter = 320, distance_saturn = 560, distance_uranus = 820, distance_neptun = 1000;

    // 40.0 ; 70.0 ; 100.0 ; 150.0 ; 320.0 ; 560.0 ; 820.0 ; 1000.0

    Planeten[0].setOrbitType("kreisBewegung", distance_mercury * distanceScale, 1/87.969);
    Planeten[1].setOrbitType("kreisBewegung", distance_venus * distanceScale, 1/224.701);
    Planeten[2].setOrbitType("kreisBewegung", distance_earth * distanceScale, 1/365.256);
    Planeten[3].setOrbitType("kreisBewegung", distance_mars * distanceScale, 1/686.980);
    Planeten[4].setOrbitType("kreisBewegung", distance_jupiter * distanceScale, 1/(11.863*365.0));
    Planeten[5].setOrbitType("kreisBewegung", distance_saturn * distanceScale, 1/(29.457*365.0));
    Planeten[6].setOrbitType("kreisBewegung", distance_uranus * distanceScale, 1/(84.011*365.0));
    Planeten[7].setOrbitType("kreisBewegung", distance_neptun * distanceScale, 1/(164.79*365.0));

    Planeten[0].setScaling(QVector3D(0.40,0.4,0.4));
    Planeten[1].setScaling(QVector3D(0.8,0.8,0.8));
    Planeten[2].setScaling(QVector3D(1.6,1.6,1.6));
    Planeten[3].setScaling(QVector3D(1.2,1.2,1.2));
    Planeten[4].setScaling(QVector3D(6.0,6.0,6.0));
    Planeten[5].setScaling(QVector3D(2.6,2.6,2.6));
    Planeten[6].setScaling(QVector3D(2.3,2.3,2.3));
    Planeten[7].setScaling(QVector3D(4.5,4.5,4.5));

    // Connect Run() method to simulation timer
    connect(SIMULATION_TIMER, &QTimer::timeout, this, &Simulation::Run);

}

void Simulation::Run(){
    for(int i = 0; i < anzahlPlaneten();i++){
        Planeten[i].kreisBewegung();
    }
}

void Simulation::Reset(){
    stopTimer();
    for(int i = 0; i<anzahlPlaneten();i++){
        Planeten[i].resetPosition();
    }
}

void Simulation::setSpeedMultiplier(qreal multiplier){
    Planet::speedMultiplier = multiplier;
}

// Timer control
void Simulation::startTimer(){
    qDebug()<<"Simulation Started";
    simulTimerRunning = true;
    // Start simulation timer
    SIMULATION_TIMER->start(16);

#ifdef DEBUG_IS_ENABLED
    // Start debug timer
    DEBUG_TIMER->start(250);
#endif
}

void Simulation::stopTimer(){
    qDebug()<<"Simulation Paused";
    simulTimerRunning = false;
    SIMULATION_TIMER->stop();
#ifdef DEBUG_IS_ENABLED
    DEBUG_TIMER->stop();
#endif
}

void Simulation::tooglePlayPause(){
    if(simulTimerRunning==true){
        stopTimer();
    } else {
        startTimer();
    }
}
