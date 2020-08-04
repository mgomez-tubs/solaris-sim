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

void consoleOutputHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    Q_UNUSED(context);
    QByteArray localMsg = msg.toLocal8Bit();
    if(localMsg.length()>200){
        localMsg.truncate(200);
        localMsg.append(" [...]");
    }
    switch (type) {
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
    if(localMsg.length()>200){
        localMsg.truncate(200);
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


