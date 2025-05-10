#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "controllers/system.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    System m_systemHandler;

    QQmlApplicationEngine engine;

    QQmlContext * context(engine.rootContext());
    context->setContextProperty("systemHandler", &m_systemHandler);

    qDebug() << QT_VERSION_STR;

    const QUrl url(QStringLiteral("qrc:/infotainment/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
