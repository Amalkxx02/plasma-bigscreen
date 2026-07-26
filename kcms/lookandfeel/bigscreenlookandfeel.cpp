/***************************************************************************
 *                                                                         *
 *   SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>         *
 *   SPDX-FileCopyrightText: 2015 Sebastian Kügler <sebas@kde.org>         *
 *                                                                         *
 *   SPDX-License-Identifier: GPL-2.0-or-later                             *
 ***************************************************************************/

#include "bigscreenlookandfeel.h"
#include "colorschemelistmodel.h"

#include <QDBusConnection>
#include <QDBusMessage>
#include <QQuickItem>

#include <KAboutData>
#include <KConfigGroup>
#include <KLocalizedString>
#include <KPluginFactory>

#include <KQuickConfigModule>

#include <QDBusInterface>

BigscreenLookandfeel::BigscreenLookandfeel(QObject *parent, const KPluginMetaData &data)
    : KQuickConfigModule(parent, data)
    , m_config(KSharedConfig::openConfig(QStringLiteral("kdeglobals")))
    , m_colorSchemeListModel(new ColorSchemeListModel(this))
{
    setButtons(Apply);

    qmlRegisterAnonymousType<ColorSchemeListModel>("ColorSchemeListModel", 1);
    loadColorSchemeName();
    connect(m_colorSchemeListModel, &ColorSchemeListModel::colorSchemeChanged, this, &BigscreenLookandfeel::loadColorSchemeName);
}

void BigscreenLookandfeel::load()
{
    loadColorSchemeName();
}

BigscreenLookandfeel::~BigscreenLookandfeel() = default;

void BigscreenLookandfeel::activateWallpaperSelector()
{
    QDBusInterface("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", QDBusConnection::sessionBus()).asyncCall("activateWallpaperSelector");
}

void BigscreenLookandfeel::loadColorSchemeName()
{
    m_config->reparseConfiguration();
    KConfigGroup generalGroup(m_config, QStringLiteral("General"));
    const QString colorSchemeName = generalGroup.readEntry("ColorScheme", QStringLiteral("BreezeLight"));

    if (colorSchemeName != m_colorSchemeName) {
        m_colorSchemeName = colorSchemeName;
        Q_EMIT colorSchemeNameChanged();
    }
}

QString BigscreenLookandfeel::colorSchemeName() const
{
    return m_colorSchemeName;
}

bool BigscreenLookandfeel::useColoredTiles()
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "coloredTilesActive");
    QDBusMessage response = QDBusConnection::sessionBus().call(msg);
    QList<QVariant> responseArg = response.arguments();
    return !responseArg.isEmpty() ? responseArg.at(0).toBool() : true;
}

void BigscreenLookandfeel::setUseColoredTiles(bool useColoredTiles)
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "useColoredTiles");
    msg << useColoredTiles;
    QDBusConnection::sessionBus().send(msg);
}

bool BigscreenLookandfeel::useWallpaperBlur()
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "wallpaperBlurActive");
    QDBusMessage response = QDBusConnection::sessionBus().call(msg);
    QList<QVariant> responseArg = response.arguments();
    return !responseArg.isEmpty() ? responseArg.at(0).toBool() : false;
}

void BigscreenLookandfeel::setUseWallpaperBlur(bool useWallpaperBlur)
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "useWallpaperBlur");
    msg << useWallpaperBlur;
    QDBusConnection::sessionBus().send(msg);
}

bool BigscreenLookandfeel::useDarkenTiles()
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "darkenTilesActive");
    QDBusMessage response = QDBusConnection::sessionBus().call(msg);
    QList<QVariant> responseArg = response.arguments();
    return !responseArg.isEmpty() ? responseArg.at(0).toBool() : true;
}

void BigscreenLookandfeel::setUseDarkenTiles(bool useDarkenTiles)
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "useDarkenTiles");
    msg << useDarkenTiles;
    QDBusConnection::sessionBus().send(msg);
}

bool BigscreenLookandfeel::useHeroBackground()
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "heroBackgroundActive");
    QDBusMessage response = QDBusConnection::sessionBus().call(msg);
    QList<QVariant> responseArg = response.arguments();
    return !responseArg.isEmpty() ? responseArg.at(0).toBool() : true;
}

void BigscreenLookandfeel::setUseHeroBackground(bool useHeroBackground)
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "useHeroBackground");
    msg << useHeroBackground;
    QDBusConnection::sessionBus().send(msg);
}

bool BigscreenLookandfeel::useDarkenHeroImage()
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "darkenHeroImageActive");
    QDBusMessage response = QDBusConnection::sessionBus().call(msg);
    QList<QVariant> responseArg = response.arguments();
    return !responseArg.isEmpty() ? responseArg.at(0).toBool() : true;
}

void BigscreenLookandfeel::setUseDarkenHeroImage(bool useDarkenHeroImage)
{
    QDBusMessage msg = QDBusMessage::createMethodCall("org.kde.biglauncher", "/BigLauncher", "org.kde.biglauncher", "useDarkenHeroImage");
    msg << useDarkenHeroImage;
    QDBusConnection::sessionBus().send(msg);
}

ColorSchemeListModel *BigscreenLookandfeel::colorSchemeListModel()
{
    return m_colorSchemeListModel;
}

K_PLUGIN_CLASS_WITH_JSON(BigscreenLookandfeel, "kcm_mediacenter_bigscreen_lookandfeel.json")

#include "bigscreenlookandfeel.moc"