#include "mainwindow.h"
#include "ui_mainwindow.h"

#include <Qt3DQuickExtras/qt3dquickwindow.h>
#include <QGuiApplication>
#include <QtQuickWidgets/QQuickWidget>
#include <QHBoxLayout>
#include <QDebug>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    // Starting size of the QuickWidget
    ui->quickWidget->setGeometry(10,10,this->geometry().width()-20,200);
    //ui->quickWidget->setSource(QUrl("qrc:/main.qml"));
}

MainWindow::~MainWindow()
{
    delete ui;
}
