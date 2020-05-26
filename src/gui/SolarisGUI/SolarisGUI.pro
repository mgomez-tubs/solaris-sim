!include(examples.pri ) {
    error( "Couldn't find the examples.pri file!" )
}
### QT dependencies
##  3D engine
QT += 3dcore 3drender 3dinput 3dquick 3dlogic qml quick 3dquickextras
##  main window
QT += core gui
## Widgets - DONT FORGET THIS ! ! !
QT += quickwidgets
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++11

SOURCES += \
        backend.cpp \
        main.cpp \
        mainwindow.cpp

FORMS += \
    mainwindow.ui

OTHER_FILES += \
    main.qml

RESOURCES += \
    qml.qrc

HEADERS += \
    backend.h \
    beispieleGUITexte.h \
    mainwindow.h \

DISTFILES +=

