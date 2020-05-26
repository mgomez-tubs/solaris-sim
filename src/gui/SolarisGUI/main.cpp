#include "mainwindow.h"
#include "BackEnd.h"

#include <QApplication>

#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>
#include <QQmlApplicationEngine>



int main(int argc, char* argv[])
{
    QApplication a(argc, argv);
    qmlRegisterType<BackEnd>("io.qt.examples.backend",1,0,"BackEnd");   // This comes BEFORE creating the main window!!
    MainWindow w;
    // Register Backend Class as a type, for it to be accessible from QML

    w.show();

    // view.show();
    return a.exec();
}

