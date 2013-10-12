#ifndef MEDIABACKEND_H
#define MEDIABACKEND_H

#include <QObject>

#include <QStringList>
#include <qdebug.h>

class MediaBackend : public QObject
{
    Q_OBJECT
public:
    explicit MediaBackend(QObject *parent = 0);
    Q_INVOKABLE QStringList songList(const QString &album);
    Q_INVOKABLE QStringList albumList();
    
signals:
    
public slots:
    
};

#endif // MEDIABACKEND_H
