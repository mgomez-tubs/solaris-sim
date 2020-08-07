#include "simulation.h"
#include <QDebug>
#include <QDir>
#include <QDirIterator>

#include "Data_Calling/Header_Info.h"
#include "Data_Calling/Header_Planet.h"
#include <vector>

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
    // Connections (currently only used for debugging purposes)
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

    // Set up planet properties
    // Order Number
    Planeten[anzahlPlaneten()].setOrder(anzahlPlaneten());
    // Root object pointer, name and ID
    Planeten[anzahlPlaneten()].setProperties(rootObject,name,id);

    // Up the planet counter
    this->addOnePlanet();
}

void Simulation::addZwergPlanet(QObject *rootObject, QString name, QString id){

    // Set up planet properties
    // Order Number
    ZwergPlaneten[anzahlZwergPlaneten()].setOrder(anzahlZwergPlaneten());
    // Root object pointer, name and ID
    ZwergPlaneten[anzahlZwergPlaneten()].setProperties(rootObject,name,id);

    // Up the small planet counter
    this->addOneZwergPlanet();
}

void Simulation::Init(){

    // Set Up QML Connections
    connect(rootObject,SIGNAL(tooglePlayPause()),   this,SLOT(tooglePlayPause()));
    connect(rootObject,SIGNAL(resetSimulation()),   this,SLOT(Reset()));
    connect(rootObject,SIGNAL(setSpeedMultiplier(qreal)), this,SLOT(setSpeedMultiplier(qreal)));
    connect(rootObject,SIGNAL(setPreset_main()), this,SLOT(setPreset_main()));

    //  Add the (main) Planets
    addPlanet(rootObject,"Merkur","merkur");    //0
    addPlanet(rootObject,"Venus","venus");      //1
    addPlanet(rootObject,"Erde","erde");        //2
    addPlanet(rootObject,"Mars","mars");        //3
    addPlanet(rootObject,"Jupiter","jupiter");  //4
    addPlanet(rootObject,"Saturn", "saturn");   //5
    addPlanet(rootObject,"Uranus","uranus");    //6
    addPlanet(rootObject,"Neptun", "neptun");   //7
    qDebug()<< "Planets created";

    // Add the small planets
    addZwergPlanet(rootObject,"Ceres", "ceres");    // this one is between mars and jupiter
    addZwergPlanet(rootObject,"Pluto", "pluto");
    addZwergPlanet(rootObject,"Haumea", "haumea");
    addZwergPlanet(rootObject,"MakeMake", "makemake");
    addZwergPlanet(rootObject,"Eris", "eris");
    qDebug()<<"Small planets created";

    distanceScale = 3;

    //int distance_mercury = 40, distance_venus = 70, distance_earth = 100, distance_mars = 150, distance_jupiter = 320, distance_saturn = 560, distance_uranus = 820, distance_neptun = 1000;

    //int distance_venus = 40, distance_earth = 40, distance_mars = 40, distance_jupiter = 40, distance_saturn = 40, distance_uranus = 40, distance_neptun = 40;

    //distance_mercury = 0;

    /*
    planet_distance[0] = 0;
    planet_distance[2] = 0;
    planet_distance[3] = 0;
    planet_distance[4] = 0;
    planet_distance[5] = 0;
    planet_distance[6] = 0;
    planet_distance[7] = 0;
    */

    planet_distance[0] = 40;        // Merkur
    planet_distance[1] = 50;        // Venus
    planet_distance[2] = 70;        // Erde
    planet_distance[3] = 150;       // Mars
    planet_distance[4] = 320;       // Jupiter
    planet_distance[5] = 560;       // Saturn
    planet_distance[6] = 820;       // Uranus
    planet_distance[7] = 1000;      // Neptun

    // 40.0 ; 70.0 ; 100.0 ; 150.0 ; 320.0 ; 560.0 ; 820.0 ; 1000.0

    // Set up planet orbits
    // Syntax: void setOrbitType({type of orbit},{distance to the sun},{scale of the distance},{angular velocity}
    Planeten[0].setOrbitType("kreisBewegung", planet_distance[0] * distanceScale, 1/87.969);
    Planeten[1].setOrbitType("kreisBewegung", planet_distance[1] * distanceScale, 1/224.701);
    Planeten[2].setOrbitType("kreisBewegung", planet_distance[2] * distanceScale, 1/365.256);
    Planeten[3].setOrbitType("kreisBewegung", planet_distance[3] * distanceScale, 1/686.980);
    Planeten[4].setOrbitType("kreisBewegung", planet_distance[4] * distanceScale, 1/(11.863*365.0));
    Planeten[5].setOrbitType("kreisBewegung", planet_distance[5] * distanceScale, 1/(29.457*365.0));
    Planeten[6].setOrbitType("kreisBewegung", planet_distance[6] * distanceScale, 1/(84.011*365.0));
    Planeten[7].setOrbitType("kreisBewegung", planet_distance[7] * distanceScale, 1/(164.79*365.0));

    // Set up planet scaling
    Planeten[0].setScaling(QVector3D(0.40,0.4,0.4));
    Planeten[1].setScaling(QVector3D(0.8,0.8,0.8));
    Planeten[2].setScaling(QVector3D(1.6,1.6,1.6));
    Planeten[3].setScaling(QVector3D(1.2,1.2,1.2));
    Planeten[4].setScaling(QVector3D(6.0,6.0,6.0));
    Planeten[5].setScaling(QVector3D(2.6,2.6,2.6));
    Planeten[6].setScaling(QVector3D(2.3,2.3,2.3));
    Planeten[7].setScaling(QVector3D(4.5,4.5,4.5));

    // Set up small planet orbits (same syntax as regular planets)
    ZwergPlaneten[0].setOrbitType("kreisBewegung", 200*distanceScale, 0.01);        //Ceres
    ZwergPlaneten[1].setOrbitType("kreisBewegung", 1200*distanceScale, 0.01);       // Pkuto
    ZwergPlaneten[2].setOrbitType("kreisBewegung", 1300*distanceScale, 0.01);       //haumea
    ZwergPlaneten[3].setOrbitType("kreisBewegung", 1400*distanceScale, 0.01);
    ZwergPlaneten[4].setOrbitType("kreisBewegung", 1500*distanceScale, 0.01);

    //                  Acquire external data
    // This includes orbit simulation data and planet information texts.

    // First change the working directory
    QDir::setCurrent(qApp->applicationDirPath());

    // Fill orDt (orbit data) struct for each planet
    for(int i = 0; i < anzahlPlaneten()-1;i++){                                     // [!] Only until Uranus since seems to be wrong
        Planeten[i].orDt.p      = getPlanetOrbitInfo(i).at(0);
        Planeten[i].orDt.l_ha   = getPlanetOrbitInfo(i).at(1);
        Planeten[i].orDt.ex     = getPlanetOrbitInfo(i).at(2);
        Planeten[i].orDt.v_mo   = getPlanetOrbitInfo(i).at(3);
        Planeten[i].orDt.d_aeq  = getPlanetOrbitInfo(i).at(4);
        Planeten[i].orDt.d_pol  = getPlanetOrbitInfo(i).at(5);
        Planeten[i].orDt.m      = getPlanetOrbitInfo(i).at(6);                      // [!] One number is missing from many planets
    }

    // Fill info text string for each planet
    for(int i = 0; i < anzahlPlaneten();i++){                                     // [!] Only until Uranus since seems to be wrong
        //qDebug()<<"Writing Text info for planet " << Planeten[i].getName();
        Planeten[i].setInfoTextHTML(getPlanetInfoString(i));
    }

    // Connect Run() method to simulation timer. This automatically starts the simulation.
    connect(SIMULATION_TIMER, &QTimer::timeout, this, &Simulation::Run);

}

void Simulation::Run(){
/*  This function is constantly called according to the QTimer SIMULATION TIMER
 *  Each planet has a function which controls its position. That function is called here.
 */
    for(int i = 0; i < anzahlPlaneten();i++){
        Planeten[i].kreisBewegung();
    }
    for(int i = 0; i < anzahlZwergPlaneten();i++){
        ZwergPlaneten[i].kreisBewegung();
    }
}

void Simulation::Reset(){
    /*  When the simulation is reset, the following steps follow:
     * 1) Simulation Timer is stopped.
     * 2) Every planet returns to its starting position
     * 3) The scaling is reset to its default value
     *
     */

    // Stop timer
    stopTimer();

    // Reset position for each planet
    for(int i = 1; i<anzahlPlaneten();i++){
        Planeten[i].resetPosition();
    }

    qDebug()<<distanceScale;
    Planeten[0].setOrbitType("kreisBewegung", planet_distance[0] * distanceScale, 1/87.969);
    Planeten[1].setOrbitType("kreisBewegung", planet_distance[1] * distanceScale, 1/224.701);
    Planeten[2].setOrbitType("kreisBewegung", planet_distance[2] * distanceScale, 1/365.256);
    Planeten[3].setOrbitType("kreisBewegung", planet_distance[3] * distanceScale, 1/686.980);
    Planeten[4].setOrbitType("kreisBewegung", planet_distance[4] * distanceScale, 1/(11.863*365.0));
    Planeten[5].setOrbitType("kreisBewegung", planet_distance[5] * distanceScale, 1/(29.457*365.0));
    Planeten[6].setOrbitType("kreisBewegung", planet_distance[6] * distanceScale, 1/(84.011*365.0));
    Planeten[7].setOrbitType("kreisBewegung", planet_distance[7] * distanceScale, 1/(164.79*365.0));

    Planeten[0].setScaling(QVector3D(0.40,0.4,0.4));
    Planeten[1].setScaling(QVector3D(0.8,0.8,0.8));
    Planeten[2].setScaling(QVector3D(1.6,1.6,1.6));
    Planeten[3].setScaling(QVector3D(1.2,1.2,1.2));
    Planeten[4].setScaling(QVector3D(6.0,6.0,6.0));
    Planeten[5].setScaling(QVector3D(2.6,2.6,2.6));
    Planeten[6].setScaling(QVector3D(2.3,2.3,2.3));
    Planeten[7].setScaling(QVector3D(4.5,4.5,4.5));
}

void Simulation::setSpeedMultiplier(qreal multiplier){      // what is this
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
    // Stop simulation timer
    SIMULATION_TIMER->stop();
#ifdef DEBUG_IS_ENABLED
    DEBUG_TIMER->stop();
#endif
}

void Simulation::tooglePlayPause(){
    /*  This function toogles between the paused and resumed states
     *  of the simulation.
     */
    if(simulTimerRunning==true){
        stopTimer();
    } else {
        startTimer();
    }
}

void Simulation::setPreset_main(){

    //qDebug() << "wert mercury : " << distance_mercury;

    qDebug() << "wert merkur liste: " <<planet_distance[0];

    planet_distance[0] = 40;
    planet_distance[1] = 70;
    planet_distance[2] = 100;
    planet_distance[3] = 150;
    planet_distance[4] = 320;
    planet_distance[5] = 560;
    planet_distance[6] = 820;
    planet_distance[7] = 1000;

    // 40.0 ; 70.0 ; 100.0 ; 150.0 ; 320.0 ; 560.0 ; 820.0 ; 1000.0

    //distance_mercury = 40,

    //qDebug() << "wert mercury : " << distance_mercury;

    qDebug() << "wert merkur liste: " <<planet_distance[0];

    qDebug()<<"Simulation.cpp: setPreset_main() erfolgreich aufgerufen.";

    Reset();

    startTimer();

}

QString Simulation::getPlanetInfoString(int planetID){
    Information Info;
    QString s;
    std::vector<std::vector<std::string>> infoOUT = Info.calling();
    std::string str;

    unsigned int j = 0;
    do{
        str = infoOUT[planetID][j];    // First element: planet ID
        //std::cout << str << '\n';
        s.append(QString::fromStdString(str));
        s.append("<br>");
        j++;
    } while (j < infoOUT[planetID].size());

    return s;
}

QVector<float> Simulation::getPlanetOrbitInfo(int planetID){
    call Call;
    float f;
    QVector<float> v;       // vector to be returned
    std::vector<std::vector<float>> dataOUT = Call.calling();

    unsigned int i = 0;
    do{
        f = dataOUT[planetID][i];    // First element: planet ID
        v.append(f);
        i++;
    } while (i < dataOUT[planetID].size());
    return v;
}
