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

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Create Window
    QApplication app(argc, argv);   // use QApplication only for debug widget, else QGuiApplication is more appropiate
                                    // if changing to QGuiApplication remove QApplication header!

    // Environment variables
    qDebug()<<qputenv("QSG_INFO", "1");

    // Create engine object
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    // Something added by qt creator?
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);    

    // Load engine in Window
    engine.load(url);           /*[!] The QObject is created IN THIS LINE !! */

    // ++++                     -----------------------                        ++++ //

    // Create a pointer to the root QML Object (needed for editing QML properties)
    QObject *rootObject = engine.rootObjects().first();

    // Start Simulation object
    Simulation s(rootObject);

    return app.exec();
}
