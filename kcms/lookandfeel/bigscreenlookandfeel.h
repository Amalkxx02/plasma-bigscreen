/***************************************************************************
 *                                                                         *
 *   SPDX-FileCopyrightText: 2021 Aditya Mehra <aix.m@outlook.com>         *
 *   SPDX-FileCopyrightText: 2015 Sebastian Kügler <sebas@kde.org>         *
 *                                                                         *
 *   SPDX-License-Identifier: GPL-2.0-or-later                             *
 ***************************************************************************/

#ifndef BIGSCREENLOOKANDFEEL_H
#define BIGSCREENLOOKANDFEEL_H

#include "colorschemelistmodel.h"
#include <KQuickConfigModule>
#include <KSharedConfig>
#include <QObject>
#include <QVariant>
#include <qtmetamacros.h>

class BigscreenLookandfeel : public KQuickConfigModule
{
    Q_OBJECT

    Q_PROPERTY(QString colorSchemeName READ colorSchemeName NOTIFY colorSchemeNameChanged)
    Q_PROPERTY(ColorSchemeListModel *colorSchemeListModel READ colorSchemeListModel CONSTANT)
public:
    BigscreenLookandfeel(QObject *parent, const KPluginMetaData &data);
    ~BigscreenLookandfeel() override;

    QString colorSchemeName() const;
    void loadColorSchemeName();

    ColorSchemeListModel *colorSchemeListModel();

public Q_SLOTS:
    void load() override;

    Q_INVOKABLE void activateWallpaperSelector();

    bool useColoredTiles();
    void setUseColoredTiles(bool useColoredTiles);

    bool useWallpaperBlur();
    void setUseWallpaperBlur(bool useWallpaperBlur);

    bool useDarkenTiles();
    void setUseDarkenTiles(bool useDarkenTiles);

    bool useHeroBackground();
    void setUseHeroBackground(bool useHeroBackground);

    bool useDarkenHeroImage();
    void setUseDarkenHeroImage(bool useDarkenHeroImage);

Q_SIGNALS:
    void colorSchemeNameChanged();

private:
    KSharedConfigPtr m_config;
    QString m_colorSchemeName;
    ColorSchemeListModel *m_colorSchemeListModel;
};

#endif // BIGSCREENLOOKANDFEEL_H
