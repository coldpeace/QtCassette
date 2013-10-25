#include "mediabackend.h"
#include <QDirIterator>
#include <qdebug.h>

static QStringList songs(const QString &album)
{
    qDebug() << Q_FUNC_INFO << album;
    QStringList songs;
    QDirIterator it(album, QDir::Dirs | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                    QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString subDir = it.next();
        qDebug() << subDir;
        QStringList audioFiles = QDir(subDir).entryList(QStringList() << "*.mp3");
        qDebug() << audioFiles.size();
        if (!audioFiles.isEmpty())
            songs << subDir;
    }

    return songs;
}

MediaBackend::MediaBackend(QObject *parent) :
    QObject(parent)
{
    qDebug() << "MediaBackend::MediaBackend";
}

QStringList MediaBackend::songList(const QString &album)
{
    qDebug() << "songList";
    QStringList musicList;
    QStringList list = QDir(album).entryList(QStringList() << "*.mp3");
    foreach (QString song, list)
        musicList << album + "/" + song;

    return musicList;
}

QStringList MediaBackend::albumList()
{
    QStringList albumList;
    QString musicDir = QDir::homePath();
    QString sdCard = QDir::homePath();
#if defined(Q_OS_MAC)
    musicDir.append("/Music/Music");
#elif defined(Q_OS_QNX)
    musicDir = "/accounts/1000/shared";
    sdCard = "/accounts/1000/removable/sdcard/";
#endif
    albumList = songs(musicDir);
    if (!songs(sdCard).isEmpty())
        albumList <<   songs(sdCard);

    return albumList;
}

