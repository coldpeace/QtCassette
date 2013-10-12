#include "mediabackend.h"
#include <QDirIterator>

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
#if defined(Q_OS_MAC)
    musicDir.append("/Music/Music");
#elif defined(Q_OS_QNX)
    musicDir = "/accounts/1000/shared";
#endif
    QDirIterator it(musicDir, QDir::Dirs | QDir::NoDotAndDotDot | QDir::NoSymLinks,
                    QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString subDir = it.next();
        QStringList audioFiles = QDir(subDir).entryList(QStringList() << "*.mp3");
        if (!audioFiles.isEmpty())
            albumList << subDir;
    }

    return albumList;
}

