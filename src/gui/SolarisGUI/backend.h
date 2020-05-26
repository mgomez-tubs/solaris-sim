#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>


class BackEnd : public QObject
{
    Q_OBJECT
    // Q_PROPERTY declares a variable as a property which can be accesed from QML
    // Here: the variable with the name "username" is specified as a property
    // READ indicates the method to be called for reading the variable
    // WRITE indicates the method to be called for writing the variable

    // CONSTANT tells the compiler that the property will not change. Using the WRITE flag
    // will ignore the CONSTANT flag.

    Q_PROPERTY(QString userName READ userName CONSTANT)

public:
    explicit BackEnd(QObject *parent = nullptr);

    QString userName();
    void setUserName(const QString &userName);  // sends a Signal every time m_UserName changes

private:
    QString m_userName;
};

#endif // BACKEND_H
