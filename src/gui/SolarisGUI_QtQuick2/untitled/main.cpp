//#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QObject>

// Project headers
#include "simulation.h"
#include <QtQuick3D/qquick3d.h>
#include <QtQuickControls2>
#include "QML/drawcircleqt.h"

int main(int argc, char *argv[])
{
    // ++++                     Load Window and Engine                        ++++ //

    // Create Window
    QApplication app(argc, argv);   // use QApplication only for debug widget, else QGuiApplication is more appropiate
                                    // if changing to QGuiApplication remove QApplication header!
    QSurfaceFormat::setDefaultFormat(QQuick3D::idealSurfaceFormat());
    // Environment variables
    // qDebug()<<qputenv("QSG_INFO", "1");

    // Create engine object
    QQmlApplicationEngine engine;

    // Import custom QML Objects
    qmlRegisterType<DrawCircleQt>("DrawCircleQt",1,0,"DrawCircleQt");

    // Load engine
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    // ++++                     -----------------------                        ++++ //

    // Create a pointer to the root QML Object (needed for editing QML properties)
    QObject *rootObject = engine.rootObjects().first();

    // Start Simulation object
    Simulation s(rootObject);

    return app.exec();
}
