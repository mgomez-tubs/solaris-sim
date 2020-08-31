QT += quick quick3d gui quickcontrols2
QT += core

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets


CONFIG += c++17
CONFIG += qtquickcompiler
CONFIG += qml_debug
CONFIG += resources_big         # this is needed for huge files in qrc, else memory will fill to its max
CONFIG += console

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

DEFINES += DEBUG_IS_ENABLED        # uncomment to get debug feats - clean project directly afterwards!!

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        Data_Calling/planets/planets.cpp \
        QML/drawcircleqt.cpp \
        debugwindow.cpp \
        main.cpp \
        orbits.cpp \
        planet.cpp \
        simulation.cpp

RESOURCES += qml.qrc \
    assets/maps/8k_mercury.jpg \
    textures/2k_sun.jpg \
    assets/maps/0.png \
    assets/maps/2k_neptune.jpg \
    assets/maps/8k_earth_daymap.jpg \
    assets/maps/8k_jupiter.jpg \
    assets/maps/8k_mars.jpg \
    assets/maps/8k_saturn.jpg \
    assets/maps/8k_saturn_ring_alpha.png \
    assets/maps/8k_venus_surface.jpg \
    assets/maps/Uranus_rings.png \
    assets/maps/2k_uranus.jpg \
    assets/maps/4k_ceres_fictional.jpg \
    assets/maps/4k_eris_fictional.jpg \
    assets/maps/4k_haumea_fictional.jpg \
    assets/maps/4k_makemake_fictional.jpg \
    assets/maps/4k_venus_atmosphere.jpg \
    assets/maps/8k_earth_nightmap.jpg \
    assets/maps/8k_moon.jpg \
    assets/maps/charon_texture.jpg \
    assets/maps/pluto_texture.jpg \
    assets/maps/pluto_texture_nasa_stitched.jpg \
    Data_Calling/Info.txt \
    Data_Calling/Info/info_Earth.txt \
    Data_Calling/Info/info_Jupiter.txt \
    Data_Calling/Info/info_Mars.txt \
    Data_Calling/Info/info_Mercury.txt \
    Data_Calling/Info/info_Neptune.txt \
    Data_Calling/Info/info_Saturn.txt \
    Data_Calling/Info/info_Uranus.txt \
    Data_Calling/Info/info_Venus.txt \
    Data_Calling/PlData.txt \
    Data_Calling/planets/pl_earth.txt \
    Data_Calling/planets/pl_jupiter.txt \
    Data_Calling/planets/pl_mars.txt \
    Data_Calling/planets/pl_mercury.txt \
    Data_Calling/planets/pl_neptun.txt \
    Data_Calling/planets/pl_saturn.txt \
    Data_Calling/planets/pl_uranus.txt \
    Data_Calling/planets/pl_venus.txt \
    Data_Calling/planets/werte.txt


TARGET = SolarisGUI

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH +=

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Data_Calling/Header_Info.h \
    Data_Calling/Header_Planet.h \
    Data_Calling/Header_fin.h \
    QML/drawcircleqt.h \
    debugwindow.h \
    planet.h \
    simulation.h

FORMS += \
    debugwindow.ui

DISTFILES += \
    assets/Ceres.qml \
    assets/Charon.qml \
    assets/Earth_day.qml \
    assets/Earth_night.qml \
    assets/Eris.qml \
    assets/Haumea.qml \
    assets/Jupiter.qml \
    assets/Makemake.qml \
    assets/Mars.qml \
    assets/Mercury.qml \
    assets/Moon.qml \
    assets/Neptun.qml \
    assets/Pluto_normal.qml \
    assets/Pluto_stiched.qml \
    assets/Saturn.qml \
    assets/Uranus.qml \
    assets/Venus.qml \
    assets/Venus_atmossphere.qml


#INCLUDEPATH += $$PWD/planetData
#DEPENDPATH += $$PWD/planetData
