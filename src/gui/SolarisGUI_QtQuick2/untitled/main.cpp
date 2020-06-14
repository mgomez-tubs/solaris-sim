#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QObject>
#include <QTimer>

// Project headers
#include "simulation.h"
#include <QtQuick3D/qquick3d.h>
#include <QtQuickControls2>

// Static stuff
// please no static stuff.

int main(int argc, char *argv[])
{
    // ++++                     Load Window and Engine                        ++++ //

    // Create Window
    QApplication app(argc, argv);   // use QApplication only for debug widget, else QGuiApplication is more appropiate
                                    // if changing to QGuiApplication remove QApplication header!

    // Environment variables
    // qDebug()<<qputenv("QSG_INFO", "1");

    QSurfaceFormat::setDefaultFormat(QQuick3D::idealSurfaceFormat());

    // Create engine object
    QQmlApplicationEngine engine;

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
