#include <QApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QObject>

// Project headers
#include "simulation.h"
#include <QtQuick3D/qquick3d.h>
#include <QtQuickControls2>
#include "QML/drawcircleqt.h"

/*  The following two functions handle console output logs.
 *  The first one will output a simplified, max. 200 char long messages.
 *  For more detailed debugging, the second function should be used.
 */
void consoleOutputHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    Q_UNUSED(context);
    QByteArray localMsg = msg.toLocal8Bit();
    if(localMsg.length()>200){
        localMsg.truncate(200);
        localMsg.append(" [...]");
    }
    switch (type) {     // The type of the message
        case QtDebugMsg:
            fprintf(stderr, "Debug: %s \n", localMsg.constData());
            break;
        case QtInfoMsg:
            fprintf(stderr, "Info: %s \n", localMsg.constData());
            break;
        case QtWarningMsg:
            fprintf(stderr, "Warning: %s \n", localMsg.constData());
            break;
        case QtCriticalMsg:
            fprintf(stderr, "Critical: %s \n", localMsg.constData());
            break;
        case QtFatalMsg:
            fprintf(stderr, "Fatal: %s \n", localMsg.constData());
            break;
        }
}

void consoleOutputHandler_verbose(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    Q_UNUSED(context);
    QByteArray localMsg = msg.toLocal8Bit();
    const char *file = context.file ? context.file : "";
    const char *function = context.function ? context.function : "";
    if(localMsg.length()>150){
        localMsg.truncate(150);
        localMsg.append(" [...]");
    }
    switch (type) {
        case QtDebugMsg:
            fprintf(stderr, "Debug: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
            break;
        case QtInfoMsg:
            fprintf(stderr, "Info: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
            break;
        case QtWarningMsg:
            fprintf(stderr, "Warning: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
            break;
        case QtCriticalMsg:
            fprintf(stderr, "Critical: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
            break;
        case QtFatalMsg:
            fprintf(stderr, "Fatal: %s (%s:%u, %s)\n", localMsg.constData(), file, context.line, function);
            break;
        }
}

/*
 *  Main Cpp function - entry point
 */
int main(int argc, char *argv[])
{
    // ++++                     Load Window and Engine                        ++++ //
    // Create Window
    QApplication app(argc, argv);   // use QApplication only for debug widget, else QGuiApplication is more appropiate
                                    // if changing to QGuiApplication remove QApplication header!
    QSurfaceFormat::setDefaultFormat(QQuick3D::idealSurfaceFormat());

    // Environment variables
    // qDebug()<<qputenv("QSG_INFO", "1");

    // Install handler for console output
    qInstallMessageHandler(consoleOutputHandler);

    // Create engine object
    QQmlApplicationEngine engine;

    // Pass applicationDirPath property to qml
    engine.rootContext()->setContextProperty("applicationDirPath", QGuiApplication::applicationDirPath());

    // Import custom QML Objects
    qmlRegisterType<DrawCircleQt>("DrawCircleQt",1,0,"DrawCircleQt");

    // Load engine
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    // ++++                     -----------------------                        ++++ //

    // ++++                     Copy program files                             ++++ //
    // If Info folder and planets folders exist, delete them and move the files
    QString path_Info = qApp->applicationDirPath();
    path_Info.append("/Info/");
    QString path_planets = qApp->applicationDirPath();
    path_planets.append("/planets/");

    // Create folders (if they don't already exist)
    QDir().mkdir(path_Info);
    QDir().mkdir(path_planets);

    // Copy needed Files into Info Folder
    QDirIterator itInfo(":/Data_Calling/Info/", QDirIterator::NoIteratorFlags);
    while(itInfo.hasNext())
    {
        itInfo.next();
        QString f = path_Info;
        f.append(itInfo.fileName());
        //qDebug()<< itInfo.filePath();
        QFile::copy(itInfo.filePath(), f);
        QFile::setPermissions(f, QFileDevice::ReadOwner|QFileDevice::WriteOwner);
    }

    // Copy needed Files into planets Folder
    QDirIterator itPlanets(":/Data_Calling/planets/", QDirIterator::NoIteratorFlags);
    while(itPlanets.hasNext())
    {
        itPlanets.next();
        QString f = path_planets;
        f.append(itPlanets.fileName());
        //qDebug()<< itPlanets.filePath();
        QFile::copy(itPlanets.filePath(), f);
        QFile::setPermissions(f, QFileDevice::ReadOwner|QFileDevice::WriteOwner);
    }

    // Copy Info.txt and PIData.txt and set correct attributes
    QFile::copy(":/Data_Calling/Info.txt", qApp->applicationDirPath()+"/Info.txt");
    QFile::setPermissions(qApp->applicationDirPath()+"/Info.txt", QFileDevice::ReadOwner|QFileDevice::WriteOwner);

    QFile::copy(":/Data_Calling/PlData.txt", qApp->applicationDirPath()+"/PlData.txt");
    QFile::setPermissions(qApp->applicationDirPath()+"/PlData.txt", QFileDevice::ReadOwner|QFileDevice::WriteOwner);
    // ++++                     -----------------------                        ++++ //


    // Create a pointer to the root QML Object (needed for editing QML properties)
    QObject *rootObject = engine.rootObjects().first();

    // Start Simulation object
    Simulation s(rootObject);

    return app.exec();
}


