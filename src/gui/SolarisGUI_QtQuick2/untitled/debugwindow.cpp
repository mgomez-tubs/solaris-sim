#include "debugwindow.h"

DebugWindow::DebugWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::DebugWindow)
{
    ui->setupUi(this);
    model1 = ui->tableWidget->model();
/*
    auto model = ui->tableWidget->model();                          // DIESE und die nächste Zeile nicht löschen!!
    model->setData(model->index(1,0),QStringLiteral("TEST"));       // auch wenn eventuell unnötigt (als kommentar setzen)
*/
}

void DebugWindow::setTableValues(int zeile, QVector3D vec){
    model1->setData(model1->index(zeile,0),vec.x());
    model1->setData(model1->index(zeile,1),vec.y());
}

DebugWindow::~DebugWindow()
{
    delete ui;
}

void DebugWindow::addRow(QString rowName){
    ui->tableWidget->insertRow(ui->tableWidget->rowCount());
    qDebug()<<ui->tableWidget->rowCount();
    ui->tableWidget->setVerticalHeaderItem(ui->tableWidget->rowCount()-1,new QTableWidgetItem(rowName));    // use setVerticalHeaderItem when to create and verticalheaderitem to cange already created row
}

void DebugWindow::foo_slot(){
    qDebug()<<"askjdnaksd";
}

void DebugWindow::on_restartButton_clicked()
{
    emit resumeSimulation();
}

void DebugWindow::on_stopButton_clicked()
{
    emit stopSimulation();
}
