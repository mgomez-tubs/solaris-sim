#include "simulation.h"
#include <QDebug>

Simulation::Simulation(QObject * rootObject)
{
    // Set root object
    this->rootObject = rootObject;

    // Set timers
    this->SIMULATION_TIMER = new QTimer(this);
    this->DEBUG_TIMER = new QTimer(this);

    // Initialize planets
    this->Init();

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
    // Connections
#ifdef DEBUG_IS_ENABLED
    // Beim Erstellen eines neues Planets eine neue Zeile in DEBUG WINDOW hinzufügen
    connect(&Planeten[anzahlPlaneten()], &Planet::rowNameEmitter,&w,&DebugWindow::addRow);

    // Bei jedem timeout von DEBUG_TIMER rufe die Methode positionEmitter_helper auf
    connect(DEBUG_TIMER, &QTimer::timeout, &Planeten[anzahlPlaneten()], &Planet::positionEmitter_helper);

    // Wenn positionEmitter aufgerufen wird, aktualisiere die Daten in der Tabelle
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
    addPlanet(rootObject,"Merkur","merkur");    // find a way to dynamically create objects
    addPlanet(rootObject,"Venus","venus");
    addPlanet(rootObject,"Erde","erde");
    addPlanet(rootObject,"Mars","mars");

    Planeten[0].setOrbitType("kreisBewegung", 100.0, .0015);
    Planeten[1].setOrbitType("kreisBewegung", 200.0, .0045);
    Planeten[2].setOrbitType("kreisBewegung", 300.0, .0155);
    Planeten[3].setOrbitType("kreisBewegung", 150.0, .0065);

    // Connect Run() method to simulation timer
    connect(SIMULATION_TIMER, &QTimer::timeout, this, &Simulation::Run);
}

void Simulation::Run(){
    for(int i = 0; i < anzahlPlaneten();i++){
        Planeten[i].kreisBewegung();
    }
}

void Simulation::Reset(){

}

// Timer control
void Simulation::startTimer(){
    // Start simulation timer
    SIMULATION_TIMER->start(16);
    // Start debug timer
    DEBUG_TIMER->start(250);
}

void Simulation::stopTimer(){
    SIMULATION_TIMER->stop();
    DEBUG_TIMER->stop();
}
