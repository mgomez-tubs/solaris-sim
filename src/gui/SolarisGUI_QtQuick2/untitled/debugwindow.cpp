#include "debugwindow.h"
#include <QtMath>

/*
 *  This contains an early development DEBUG Window.
 *  It is accesible by enabling the flag QT_DEBUG_IS_ENABLED in untitled.pro
 */

DebugWindow::DebugWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::DebugWindow)
{
    Qt::WindowFlags flags;
    flags = Qt::Dialog;
    ui->setupUi(this);
    model1 = ui->tableWidget->model();
/*
    auto model = ui->tableWidget->model();                          // DIESE und die nächste Zeile nicht löschen!!
    model->setData(model->index(1,0),QStringLiteral("TEST"));       // auch wenn eventuell unnötigt (als kommentar setzen)
*/
}

/*
 *  Fill table data
 */
void DebugWindow::setTableValues(int zeile, QVector3D vec, float angle){
    model1->setData(model1->index(zeile,0),vec.x());
    model1->setData(model1->index(zeile,1),vec.y());
    model1->setData(model1->index(zeile,2),qRadiansToDegrees(angle));
}

/*
 * Destructor
 */
DebugWindow::~DebugWindow()
{
    delete ui;
}

/*
 *  Add a new row (for each planet)
 */
void DebugWindow::addRow(QString rowName){
    ui->tableWidget->insertRow(ui->tableWidget->rowCount());
    ui->tableWidget->setVerticalHeaderItem(ui->tableWidget->rowCount()-1,new QTableWidgetItem(rowName));    // use setVerticalHeaderItem when to create and verticalheaderitem to cange already created row
}

/*
 *  Slot for testing
 */
void DebugWindow::foo_slot(){
    qDebug()<<"askjdnaksd";
}

/*
 *  Handler for click on restart button
 */
void DebugWindow::on_restartButton_clicked()
{
    emit resumeSimulation();
}

/*
 *  Handler for click on stop button
 */
void DebugWindow::on_stopButton_clicked()
{
    emit stopSimulation();
}
