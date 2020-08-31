#include "simulation.h"
#include <QDebug>
#include <QDir>
#include <QDirIterator>

// Header for handling external data
#include "Data_Calling/Header_fin.h"

#include <vector>

// ++++                     Constructor                        ++++ //
/*! \class Simulation.cpp
 * \brief Creates the simulation object.
 * \param rootObject - For interaction with QML, a pointer to the QML root object has to be
 * passed as a pointer.
 *
 */
Simulation::Simulation(QObject * rootObject)
{

    // Set root object
    this->rootObject = rootObject;
    // Set Simulation and Debug Timer
    this->SIMULATION_TIMER = new QTimer(this);
    this->DEBUG_TIMER = new QTimer(this);

    #ifdef DEBUG_IS_ENABLED
        // Display DEBUG window
        this->w.show();
    #endif

    // Closing the main window should close the whole Application
    connect(rootObject, SIGNAL(mainWclosed()),
            qApp, SLOT(quit()));

    // Start Timers
    startTimer();

    // Initialize Planets though Init()
    this->Init();

    // Connect Run() method to simulation timer. This automatically starts the simulation.
    connect(SIMULATION_TIMER, &QTimer::timeout, this, &Simulation::Run);
}

/*!
 * \brief Adds a planet to the planet array Planeten[] in the Simulation Object.
 *  The planet is given an order number and the input properties are set.
 * \param rootObject - For interaction with QML, a pointer to the QML root object has to be
 * passed as a pointer.
 * \param name - The name of the planet
 * \param id - The QML ID of the planet (corresponds to the property "objectName" in QML
 */
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

/*!
 * \brief This function works the same way as Simulation::addPlanet(), but it adds the planet to the
 * small planet array ZwergPlaneten[].
 */
void Simulation::addZwergPlanet(QObject *rootObject, QString name, QString id){

    // Set up planet properties
    // Order Number
    ZwergPlaneten[anzahlZwergPlaneten()].setOrder(anzahlZwergPlaneten());
    // Root object pointer, name and ID
    ZwergPlaneten[anzahlZwergPlaneten()].setProperties(rootObject,name,id);

    // Up the small planet counter
    this->addOneZwergPlanet();
}


/*!
 *  \brief Planet initialization.
 *
 *  1) Set Up QML Connections
 *  2) Add the main Planets through Simulation::addPlanet()
 *  3) Add the small Planets through Simulation::addZwergPlanet
 *  4) Set up planets orbits
 *  5) Fill planet information data from external files
 *
 */
void Simulation::Init(){

    // Set Up QML Connections
    connect(rootObject,SIGNAL(tooglePlayPause()),   this,SLOT(tooglePlayPause()));
    connect(rootObject,SIGNAL(resetSimulation()),   this,SLOT(Reset()));
    connect(rootObject,SIGNAL(setSpeedMultiplier(qreal)), this,SLOT(setSpeedMultiplier(qreal)));
    connect(rootObject,SIGNAL(setPreset_main()), this,SLOT(setPreset_main()));
    connect(rootObject,SIGNAL(getPlanet(qreal)), this,SLOT(getPlanet(qreal)));
    connect(rootObject,SIGNAL(setParameter(qreal, qreal)), this,SLOT(setParameter(qreal, qreal)));
    connect(rootObject,SIGNAL(setDistance_Scale(qreal)), this,SLOT(setDistance_Scale(qreal)));
    connect(rootObject,SIGNAL(newStart()), this,SLOT(newStart()));

    //  Add the (main) Planets
    addPlanet(rootObject,"Merkur","merkur");    //0
    addPlanet(rootObject,"Venus","venus");      //1
    addPlanet(rootObject,"Erde","erde");        //2
    addPlanet(rootObject,"Mars","mars");        //3
    addPlanet(rootObject,"Jupiter","jupiter");  //4
    addPlanet(rootObject,"Saturn","saturn");    //5
    addPlanet(rootObject,"Uranus","uranus");    //6
    addPlanet(rootObject,"Neptun", "neptun");   //7
    qDebug()<< "Planets created";

    //  Add the small planets
    addZwergPlanet(rootObject,"Ceres", "ceres");        // between mars and jupiter 8
    addZwergPlanet(rootObject,"Pluto", "pluto");        //9
    addZwergPlanet(rootObject,"Haumea", "haumea");      //10
    addZwergPlanet(rootObject,"MakeMake", "makemake");  //11
    addZwergPlanet(rootObject,"Eris", "eris");          //12
    qDebug()<<"Small planets created";

    distanceScale = 3;

    planet_distance[0] = 40;
    planet_distance[1] = 70;
    planet_distance[2] = 100;
    planet_distance[3] = 150;
    planet_distance[4] = 320;
    planet_distance[5] = 560;
    planet_distance[6] = 820;
    planet_distance[7] = 1000;
    planet_distance[8] = 230;
    planet_distance[9] = 1300;
    planet_distance[10] = 1600;
    planet_distance[11] = 1750;
    planet_distance[12] = 2000;

    planet_scaling[0] = 0.4;
    planet_scaling[1] = 0.8;
    planet_scaling[2] = 1.6;
    planet_scaling[3] = 1.2;
    planet_scaling[4] = 6.0;
    planet_scaling[5] = 2.6;
    planet_scaling[6] = 2.3;
    planet_scaling[7] = 4.5;
    planet_scaling[8] = 0.6;
    planet_scaling[9] = 0.8;
    planet_scaling[10] = 0.8;
    planet_scaling[11] = 0.8;
    planet_scaling[12] = 0.8;

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

    Planeten[0].setScaling(QVector3D(planet_scaling[0],planet_scaling[0],planet_scaling[0]));
    Planeten[1].setScaling(QVector3D(planet_scaling[1],planet_scaling[1],planet_scaling[1]));
    Planeten[2].setScaling(QVector3D(planet_scaling[2],planet_scaling[2],planet_scaling[2]));
    Planeten[3].setScaling(QVector3D(planet_scaling[3],planet_scaling[3],planet_scaling[3]));
    Planeten[4].setScaling(QVector3D(planet_scaling[4],planet_scaling[4],planet_scaling[4]));
    Planeten[5].setScaling(QVector3D(planet_scaling[5],planet_scaling[5],planet_scaling[5]));
    Planeten[6].setScaling(QVector3D(planet_scaling[6],planet_scaling[6],planet_scaling[6]));
    Planeten[7].setScaling(QVector3D(planet_scaling[7],planet_scaling[7],planet_scaling[7]));

    // Small Planets
    ZwergPlaneten[0].setOrbitType("kreisBewegung", planet_distance[8]*distanceScale, 1/(4.221*365.0));        //Ceres
    ZwergPlaneten[1].setOrbitType("kreisBewegung", planet_distance[9]*distanceScale,1/(247.343*365.0));       // Pluto
    ZwergPlaneten[2].setOrbitType("kreisBewegung", planet_distance[10]*distanceScale, 1/(284.287*365.0));       //haumea
    ZwergPlaneten[3].setOrbitType("kreisBewegung", planet_distance[11]*distanceScale, 1/(307.180*365.0));       //makemake
    ZwergPlaneten[4].setOrbitType("kreisBewegung", planet_distance[12]*distanceScale, 1/(204203));              //eris

    ZwergPlaneten[0].setScaling(QVector3D(planet_scaling[8],planet_scaling[8],planet_scaling[8]));
    ZwergPlaneten[1].setScaling(QVector3D(planet_scaling[9],planet_scaling[9],planet_scaling[9]));
    ZwergPlaneten[2].setScaling(QVector3D(planet_scaling[10],planet_scaling[10],planet_scaling[10]));
    ZwergPlaneten[3].setScaling(QVector3D(planet_scaling[11],planet_scaling[11],planet_scaling[11]));
    ZwergPlaneten[4].setScaling(QVector3D(planet_scaling[12],planet_scaling[12],planet_scaling[12]));

    // ++++                     Acquire external data                        ++++ //
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
    // ++++                     -----------------------                        ++++ //

}

/*!
 *  \brief Run Simulation
 */
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

/*!
 *  \brief Reset Simulation
 */
void Simulation::Reset(){
    /*  When the simulation is reset, the following steps follow:
     * 1) Simulation Timer is stopped.
     * 2) Every planet returns to its starting position -> position is set, by using the planet_distance[] list, which can be set by multiple methods
     * 3) The scaling is reset to its default value -> not default value, the scaling is set using the planet_scaling[] list, which can be set by multiple methods
     *
     */

    // Stop timer
    stopTimer();

    // Remove all the orbit lines
    QMetaObject::invokeMethod(rootObject, "removeAllOrbits");

    // Reset position for each planet
    for(int i = 1; i<anzahlPlaneten();i++){
        Planeten[i].resetPosition();
    }

    //set new position and scaling for each planet
    qDebug()<<distanceScale;
    Planeten[0].setOrbitType("kreisBewegung", planet_distance[0] * distanceScale, 1/87.969);
    Planeten[1].setOrbitType("kreisBewegung", planet_distance[1] * distanceScale, 1/224.701);
    Planeten[2].setOrbitType("kreisBewegung", planet_distance[2] * distanceScale, 1/365.256);
    Planeten[3].setOrbitType("kreisBewegung", planet_distance[3] * distanceScale, 1/686.980);
    Planeten[4].setOrbitType("kreisBewegung", planet_distance[4] * distanceScale, 1/(11.863*365.0));
    Planeten[5].setOrbitType("kreisBewegung", planet_distance[5] * distanceScale, 1/(29.457*365.0));
    Planeten[6].setOrbitType("kreisBewegung", planet_distance[6] * distanceScale, 1/(84.011*365.0));
    Planeten[7].setOrbitType("kreisBewegung", planet_distance[7] * distanceScale, 1/(164.79*365.0));

    ZwergPlaneten[0].setOrbitType("kreisBewegung", planet_distance[8]*distanceScale, 1/(4.221*365.0));
    ZwergPlaneten[1].setOrbitType("kreisBewegung", planet_distance[9]*distanceScale,1/(247.343*365.0));
    ZwergPlaneten[2].setOrbitType("kreisBewegung", planet_distance[10]*distanceScale, 1/(284.287*365.0));
    ZwergPlaneten[3].setOrbitType("kreisBewegung", planet_distance[11]*distanceScale, 1/(307.180*365.0));
    ZwergPlaneten[4].setOrbitType("kreisBewegung", planet_distance[12]*distanceScale, 1/(204203));

    Planeten[0].setScaling(QVector3D(planet_scaling[0],planet_scaling[0],planet_scaling[0]));
    Planeten[1].setScaling(QVector3D(planet_scaling[1],planet_scaling[1],planet_scaling[1]));
    Planeten[2].setScaling(QVector3D(planet_scaling[2],planet_scaling[2],planet_scaling[2]));
    Planeten[3].setScaling(QVector3D(planet_scaling[3],planet_scaling[3],planet_scaling[3]));
    Planeten[4].setScaling(QVector3D(planet_scaling[4],planet_scaling[4],planet_scaling[4]));
    Planeten[5].setScaling(QVector3D(planet_scaling[5],planet_scaling[5],planet_scaling[5]));
    Planeten[6].setScaling(QVector3D(planet_scaling[6],planet_scaling[6],planet_scaling[6]));
    Planeten[7].setScaling(QVector3D(planet_scaling[7],planet_scaling[7],planet_scaling[7]));

    ZwergPlaneten[0].setScaling(QVector3D(planet_scaling[8],planet_scaling[8],planet_scaling[8]));
    ZwergPlaneten[1].setScaling(QVector3D(planet_scaling[9],planet_scaling[9],planet_scaling[9]));
    ZwergPlaneten[2].setScaling(QVector3D(planet_scaling[10],planet_scaling[10],planet_scaling[10]));
    ZwergPlaneten[3].setScaling(QVector3D(planet_scaling[11],planet_scaling[11],planet_scaling[11]));
    ZwergPlaneten[4].setScaling(QVector3D(planet_scaling[12],planet_scaling[12],planet_scaling[12]));
}

/*!
 *  \brief Handler for the speed multiplier
 */
void Simulation::setSpeedMultiplier(qreal multiplier){      // what is this //this is used in the speed dial see Layer_MainGUI.qml for reference
    Planet::speedMultiplier = multiplier;
}

/*!
 *  \brief Start Simulation Timer
 */
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

/*!
 *  \brief Stop Simulation Timer
 */
void Simulation::stopTimer(){
    qDebug()<<"Simulation Paused";
    simulTimerRunning = false;
    // Stop simulation timer
    SIMULATION_TIMER->stop();
#ifdef DEBUG_IS_ENABLED
    DEBUG_TIMER->stop();
#endif
}

/*!
 *  \brief Toogle Simulation Timer (Start/Stop)
 */
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

/*!
 *  \brief Set Presets
 */
void Simulation::setPreset_main(){

    //set standard values for distance and scaling
    planet_distance[0] = 40;
    planet_distance[1] = 70;
    planet_distance[2] = 100;
    planet_distance[3] = 150;
    planet_distance[4] = 320;
    planet_distance[5] = 560;
    planet_distance[6] = 820;
    planet_distance[7] = 1000;
    planet_distance[8] = 230;
    planet_distance[9] = 1300;
    planet_distance[10] = 1600;
    planet_distance[11] = 1750;
    planet_distance[12] = 2000;

    planet_scaling[0] = 0.4;
    planet_scaling[1] = 0.8;
    planet_scaling[2] = 1.6;
    planet_scaling[3] = 1.2;
    planet_scaling[4] = 6.0;
    planet_scaling[5] = 2.6;
    planet_scaling[6] = 2.3;
    planet_scaling[7] = 4.5;
    planet_scaling[8] = 0.6;
    planet_scaling[9] = 0.8;
    planet_scaling[10] = 0.8;
    planet_scaling[11] = 0.8;
    planet_scaling[12] = 0.8;

    distanceScale = 3;

    newStart();

}

void Simulation::setDistance_Scale(qreal scaling){
    int scaling_tmp = scaling;
    distanceScale = scaling_tmp;

    newStart();
}

void Simulation::getPlanet(qreal plt_tmp){
    planet_tmp = plt_tmp;
}

/*!
 *  \brief Set Distances
 */
bool Simulation::setParameter(qreal flt_tmp, qreal array){

    bool success;

    qDebug()<< "planet nr.:" <<planet_tmp <<"wurde auf den Wert:" << flt_tmp <<"geaendert"; // used for testing purposes

    if (array == 0){                            //checks which array is edited
        int flt_tmp1 = flt_tmp;
        planet_distance[planet_tmp] = flt_tmp1;
        success = true;
    }

    else if (array ==1){
        double flt_tmp2 = flt_tmp;
        planet_scaling[planet_tmp] = flt_tmp2;
        success = true;
    }

    else{
        success = false;
        qDebug()<<"array nicht bekannt";}

    return success;

}

void Simulation::newStart(){
    Reset();

    startTimer();
}

/*!
 *  \brief Get external data for the planet information
 * \return
 */
QString Simulation::getPlanetInfoString(int planetID){
    Data_Call Info;
    QString s;
    std::vector<std::vector<std::string>> infoOUT = Info.calling("Info.txt");
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

/*!
 *  \brief Get external data for the planet orbit information
 */
QVector<float> Simulation::getPlanetOrbitInfo(int planetID){
    Data_Call Call;
    std::string f;
    QVector<QString> v;       // vector to be returned
    std::vector<std::vector<std::string>> dataOUT = Call.calling("PlData.txt");

    unsigned int i = 0;
    do{
        f = dataOUT[planetID][i];    // First element: planet ID
        v.append(QString::fromStdString(f));
        i++;
    } while (i < dataOUT[planetID].size());

    QVector<float> v_toFloat;
    for(int i = 0; i < v.length();i++){
        v_toFloat.append(v[i].toFloat());
    }
    return v_toFloat;
}
