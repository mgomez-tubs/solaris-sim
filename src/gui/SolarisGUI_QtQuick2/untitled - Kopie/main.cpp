#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

// Project headers
#include "positionhandler.h"
#include "planet.h"

#include <QtQuick3D/qquick3d.h>

int main(int argc, char *argv[])
{
    // ++++                     Load Window and Engine                        ++++ //

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    // Create Window
    QGuiApplication app(argc, argv);

    QSurfaceFormat::setDefaultFormat(QQuick3D::idealSurfaceFormat());

    // Environment variables
    //qputenv("QSG_RHI_BACKEND", "metal");
    //qputenv("QSG_RENDERER_DEBUG", "render");

    qDebug()<<qputenv("QSG_INFO", "1");
    //qDebug()<<qgetenv("QT_ANGLE_PLATFORM");

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

    // Create a pointer to the root QML Object (necessary for editing QML properties)
    QObject *rootObject = engine.rootObjects().first();

    // Create Planets
    Planet Merkur(rootObject,"Merkur","merkur");
    Planet Venus(rootObject,"Venus", "venus");
    Planet Erde(rootObject,"Erde","erde");
    Planet Mars(rootObject,"Mars","mars");

    // Animate the planets , first arg ist starting position, second argument is speed
    Merkur.circularRotation(200.0, .15);
    Venus.circularRotation(400.0, .19);
    Erde.circularRotation(600.0, .18);
    Mars.circularRotation(700.0, .1);

    return app.exec();
}
