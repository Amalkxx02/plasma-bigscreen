/*
    SPDX-FileCopyrightText: 2020 Aditya Mehra <aix.m@outlook.com>
    SPDX-FileCopyrightText: 2025 Devin Lin <devin@kde.org>

    SPDX-License-Identifier: LGPL-2.1-only OR LGPL-3.0-only OR LicenseRef-KDE-Accepted-LGPL
*/

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtQuick.Window
import org.kde.bigscreen as Bigscreen
import org.kde.bigscreen.shell as BigscreenShell
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore

Bigscreen.ScrollablePage {
    id: root

    title: i18n("Look and Feel")
    background: null
    leftPadding: Kirigami.Units.smallSpacing
    topPadding: Kirigami.Units.smallSpacing
    rightPadding: Kirigami.Units.smallSpacing
    bottomPadding: Kirigami.Units.smallSpacing
    onActiveFocusChanged: {
        if (activeFocus)
            wallpaperSelectorDelegate.forceActiveFocus();
    }

    ColumnLayout {
        // Since ScrollablePage's scrollview eats up the propagation of the left event to root, manually set it here
        KeyNavigation.left: root.KeyNavigation.left
        spacing: 0

        QQC2.Label {
            text: i18n("Global")
            font.pixelSize: Bigscreen.Units.headingFontPixelSize
            Layout.topMargin: Kirigami.Units.gridUnit
            Layout.bottomMargin: Kirigami.Units.gridUnit
        }

        Bigscreen.ButtonDelegate {
            id: wallpaperSelectorDelegate
            text: i18n("Open wallpaper selector")
            description: i18n("Select wallpapers from the system")
            Layout.fillWidth: true
            onClicked: {
                kcm.activateWallpaperSelector();
                Window.window.close();
            }
            KeyNavigation.down: colorSchemeButton
        }

        Bigscreen.ButtonDelegate {
            id: colorSchemeButton
            text: i18n("Color scheme")
            description: i18n("Set the system colors")
            raisedBackground: true
            onClicked: colorSchemeSidebar.open()
            KeyNavigation.down: windowDecorationsDelegate
        }

        Bigscreen.SwitchDelegate {
            id: windowDecorationsDelegate
            text: i18n("Window decorations")
            description: i18n("Have a window frame (minimize, maximize, close), for apps that request it")
            checked: BigscreenShell.Settings.windowDecorationsEnabled ? true : false
            onCheckedChanged: BigscreenShell.Settings.windowDecorationsEnabled = checked
            KeyNavigation.down: navigationSoundDelegate
        }

        Bigscreen.SwitchDelegate {
            id: navigationSoundDelegate
            text: i18n("Navigation sounds")
            description: i18n("Play a sound when the selected item changes in system apps")
            checked: BigscreenShell.Settings.navigationSoundEnabled ? true : false
            onCheckedChanged: BigscreenShell.Settings.navigationSoundEnabled = checked
            KeyNavigation.down: coloredTileDelegate
        }

        QQC2.Label {
            text: i18n("Homescreen")
            font.pixelSize: Bigscreen.Units.headingFontPixelSize
            Layout.topMargin: Kirigami.Units.gridUnit
            Layout.bottomMargin: Kirigami.Units.gridUnit
        }

        Bigscreen.SwitchDelegate {
            id: coloredTileDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Colored tiles")
            description: i18n("Tile backgrounds will be colored based on the app's icon")
            raisedBackground: true
            checked: kcm.useColoredTiles() ? 1 : 0
            onCheckedChanged: kcm.setUseColoredTiles(checked)
            KeyNavigation.down: wallpaperBlurDelegate
        }

        Bigscreen.SwitchDelegate {
            id: wallpaperBlurDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Wallpaper blur")
            description: i18n("Apply a blur effect to the wallpaper on the homescreen")
            raisedBackground: true
            checked: kcm.useWallpaperBlur() ? 1 : 0
            onCheckedChanged: kcm.setUseWallpaperBlur(checked)
            KeyNavigation.down: dimmedGameTileDelegate
        }

        QQC2.Label {
            text: i18n("Console Screen")
            font.pixelSize: Bigscreen.Units.headingFontPixelSize
            Layout.topMargin: Kirigami.Units.gridUnit
            Layout.bottomMargin: Kirigami.Units.gridUnit
        }

        Bigscreen.SwitchDelegate {
            id: dimmedGameTileDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Dimmed tiles")
            description: i18n("Dim the background of game tiles")
            raisedBackground: true
            checked: kcm.useDarkenTiles() ? 1 : 0
            onCheckedChanged: kcm.setUseDarkenTiles(checked)
            KeyNavigation.down: heroBackgroundDelegate
        }

        Bigscreen.SwitchDelegate {
            id: heroBackgroundDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Hero background")
            description: i18n("Use game hero image as background")
            raisedBackground: true
            checked: kcm.useHeroBackground() ? 1 : 0
            onCheckedChanged: kcm.setUseHeroBackground(checked)
            KeyNavigation.down: heroDimDelegate
        }

        Bigscreen.SwitchDelegate {
            id: heroDimDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Darken hero background")
            description: i18n("Apply a darken effect to the game hero background")
            raisedBackground: true
            checked: kcm.useDarkenHeroImage() ? 1 : 0
            onCheckedChanged: kcm.setUseDarkenHeroImage(checked)
            KeyNavigation.down: ambientSoundDelegate
        }

        Bigscreen.SwitchDelegate {
            id: ambientSoundDelegate
            text: i18n("Ambient sounds")
            description: i18n("Play background ambient sounds")
            checked: BigscreenShell.Settings.ambientSoundEnabled ? true : false
            onCheckedChanged: BigscreenShell.Settings.ambientSoundEnabled = checked
        }

        ColorSchemeSidebar {
            id: colorSchemeSidebar
            onClosed: colorSchemeButton.forceActiveFocus()
        }
    }
}
