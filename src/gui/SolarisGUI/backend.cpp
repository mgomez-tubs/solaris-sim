#include "backend.h"
#include <QString>

// calculation related headers
#include "beispieleGUITexte.h"

BackEnd::BackEnd(QObject *parent) :
    QObject(parent)
{
    this->setUserName(QString::number(functionTest1()));
}

QString BackEnd::userName()
{
    return m_userName;
}

void BackEnd::setUserName(const QString &userName)
{
    if (userName == m_userName)
        return;

    m_userName = userName;
}
