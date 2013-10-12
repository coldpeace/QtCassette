#include <QtGui/QGuiApplication>
#include <QQmlContext>
#include "qtquick2applicationviewer.h"
#include <mediabackend.h>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qDebug() << "Starting...";
    MediaBackend media;
    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("mediaBackend", &media);
    viewer.setMainQmlFile(QStringLiteral("qml/cassette/main.qml"));
    viewer.showExpanded();

    return app.exec();
}
