QT += quick quick3d gui quickcontrols2
QT += core

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets


CONFIG += c++11
CONFIG += qtquickcompiler
CONFIG += qml_debug
CONFIG += resources_big # this is needed for huge files in qrc, else memory will fill to its max
CONFIG += console
CONFIG += console qml_debug

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

#DEFINES += DEBUG_IS_ENABLED        # uncomment to get debug feats - clean project directly afterwards!!

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
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
    assets/maps/2k_uranus.jpg


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
    QML/drawcircleqt.h \
    debugwindow.h \
    planet.h \
    planetData/lib/libDatenabruf.h \
    simulation.h

FORMS += \
    debugwindow.ui

DISTFILES +=

#win32: LIBS += -L$$PWD/planetData/lib/ -lDatenabruf

#INCLUDEPATH += $$PWD/planetData
#DEPENDPATH += $$PWD/planetData
