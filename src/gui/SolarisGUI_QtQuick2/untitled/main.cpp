
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

// Project headers
#include "positionhandler.h"
#include "planet.h"

#include <QtQuick3D/qquick3d.h>
#include <QtQuickControls2>

int main(int argc, char *argv[])
{
    // ++++                     Load Window and Engine                        ++++ //

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Create Window
    QGuiApplication app(argc, argv);

    // Environment variables
    qDebug()<<qputenv("QSG_INFO", "1");

    // Create engine
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));

    // Something added by qt creator?
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);    

    // Force renderer
    //QQuickWindow::setSceneGraphBackend(QSGRendererInterface::OpenGLRhi);

    // Load engine in Window
    engine.load(url);           /*[!] The QObject is created IN THIS LINE !! */

    // ++++                     -----------------------                        ++++ //

    // Create a pointer to the root QML Object (needed for editing QML properties)
    QObject *rootObject = engine.rootObjects().first();

    // Create Planets
    Planet Merkur(rootObject,"Planet Merkur","merkur");     // name, QML id
    Planet Venus(rootObject,"Planet Venus", "venus");
    Planet Erde(rootObject,"Planet Erde","erde");
    Planet Mars(rootObject,"Planet Mars","mars");

    // Animate the planets, first arg ist starting position, second speed
    Merkur.setOrbitType("cRotation", 200.0, .15);   // cRotation : circular rotation
    Venus.setOrbitType("cRotation", 400.0, .19);
    Erde.setOrbitType("cRotation", 600.0, .18);
    Mars.setOrbitType("cRotation", 700.0, .1);
    return app.exec();
}
