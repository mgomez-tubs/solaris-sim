#ifndef DEBUGWINDOW_H
#define DEBUGWINDOW_H

#include <QWidget>
#include "ui_debugwindow.h"
#include <QPoint>
#include <QAbstractTableModel>
#include <QDebug>
#include <QVector3D>

namespace Ui {
class DebugWindow;
}

class DebugWindow : public QWidget
{
    Q_OBJECT

public:
    explicit DebugWindow(QWidget *parent = nullptr);
    QAbstractItemModel * model1;
    ~DebugWindow();

private:
    Ui::DebugWindow *ui;

public slots:
    void setTableValues(int,QVector3D,float);
    void addRow(QString);
    void foo_slot();

private slots:
    void on_restartButton_clicked();
    void on_stopButton_clicked();

signals:
    void resumeSimulation();
    void stopSimulation();
};

#endif // DEBUGWINDOW_H
