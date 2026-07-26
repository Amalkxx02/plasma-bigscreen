/*
    SPDX-FileCopyrightText: 2020 Aditya Mehra <aix.m@outlook.com>
    SPDX-FileCopyrightText: 2025 Devin Lin <devin@kde.org>

    SPDX-License-Identifier: LGPL-2.1-only OR LGPL-3.0-only OR LicenseRef-KDE-Accepted-LGPL
*/

import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls as QQC2

import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM
import org.kde.bigscreen as Bigscreen
import org.kde.bigscreen.shell as BigscreenShell

Bigscreen.ScrollablePage {
    id: root

    title: i18n("System")
    background: null

    leftPadding: Kirigami.Units.smallSpacing
    topPadding: Kirigami.Units.smallSpacing
    rightPadding: Kirigami.Units.smallSpacing
    bottomPadding: Kirigami.Units.smallSpacing

    onActiveFocusChanged: {
        if (activeFocus) {
            pmInhibitionDelegate.forceActiveFocus();
        }
    }

    ColumnLayout {
        // Since ScrollablePage's scrollview eats up the propagation of the left event to root, manually set it here
        KeyNavigation.left: root.KeyNavigation.left
        spacing: 0

        QQC2.Label {
            text: i18n("Power & Time")
            font.pixelSize: Bigscreen.Units.headingFontPixelSize

            Layout.topMargin: Kirigami.Units.gridUnit
            Layout.bottomMargin: Kirigami.Units.gridUnit
        }

        Bigscreen.SwitchDelegate {
            id: pmInhibitionDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            KeyNavigation.down: timeDateDelegate

            text: i18n("Power inhibition")
            description: i18n("Prevent the system from automatically sleeping")
            checked: BigscreenShell.Settings.pmInhibitionEnabled ? true : false
            onCheckedChanged: BigscreenShell.Settings.pmInhibitionEnabled = checked
        }

        Bigscreen.ButtonDelegate {
            id: timeDateDelegate
            KeyNavigation.down: homeOverlayShortcut

            icon.name: "preferences-system-time"
            text: i18n("Adjust date and time")

            onClicked: deviceTimeSettings.open()
        }

        QQC2.Label {
            text: i18n("Shortcuts")
            font.pixelSize: Bigscreen.Units.headingFontPixelSize

            Layout.topMargin: Kirigami.Units.gridUnit
            Layout.bottomMargin: Kirigami.Units.gridUnit
        }

        Bigscreen.ButtonDelegate {
            id: homeOverlayShortcut
            KeyNavigation.down: homescreenShortcutDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Open home overlay shortcut")
            icon.name: 'preferences-desktop-keyboard-symbolic'

            property string getActionPath: "displayHomeOverlayShortcut"
            property string setActionPath: "setDisplayHomeOverlayShortcut"
            property string resetActionPath: "resetDisplayHomeOverlayShortcut"
            onClicked: {
                shortcutsPicker.title = text;
                shortcutsPicker.currentShortcut = kcm.getShortcut(getActionPath);
                shortcutsPicker.getActionPath = getActionPath;
                shortcutsPicker.setActionPath = setActionPath;
                shortcutsPicker.resetActionPath = resetActionPath;
                shortcutsPicker.openerDelegate = homeOverlayShortcut;
                shortcutsPicker.open();
            }
        }

        Bigscreen.ButtonDelegate {
            id: homescreenShortcutDelegate
            KeyNavigation.down: settingsShortcutDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Open homescreen shortcut")
            icon.name: 'preferences-desktop-keyboard-symbolic'

            property string getActionPath: "displayHomeScreenShortcut"
            property string setActionPath: "setDisplayHomeScreenShortcut"
            property string resetActionPath: "resetDisplayHomeScreenShortcut"
            onClicked: {
                shortcutsPicker.title = text;
                shortcutsPicker.currentShortcut = kcm.getShortcut(getActionPath);
                shortcutsPicker.getActionPath = getActionPath;
                shortcutsPicker.setActionPath = setActionPath;
                shortcutsPicker.resetActionPath = resetActionPath;
                shortcutsPicker.openerDelegate = homescreenShortcutDelegate;
                shortcutsPicker.open();
            }
        }

        Bigscreen.ButtonDelegate {
            id: settingsShortcutDelegate
            KeyNavigation.down: tasksShortcutDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Open settings shortcut")
            icon.name: 'preferences-desktop-keyboard-symbolic'

            property string getActionPath: "activateSettingsShortcut"
            property string setActionPath: "setActivateSettingsShortcut"
            property string resetActionPath: "resetActivateSettingsShortcut"
            onClicked: {
                shortcutsPicker.title = text;
                shortcutsPicker.currentShortcut = kcm.getShortcut(getActionPath);
                shortcutsPicker.getActionPath = getActionPath;
                shortcutsPicker.setActionPath = setActionPath;
                shortcutsPicker.resetActionPath = resetActionPath;
                shortcutsPicker.openerDelegate = settingsShortcutDelegate;
                shortcutsPicker.open();
            }
        }

        Bigscreen.ButtonDelegate {
            id: tasksShortcutDelegate
            Layout.bottomMargin: Kirigami.Units.smallSpacing
            text: i18n("Open tasks shortcut")
            icon.name: 'preferences-desktop-keyboard-symbolic'

            property string getActionPath: "activateTasksShortcut"
            property string setActionPath: "setActivateTasksShortcut"
            property string resetActionPath: "resetActivateTasksShortcut"
            onClicked: {
                shortcutsPicker.title = text;
                shortcutsPicker.currentShortcut = kcm.getShortcut(getActionPath);
                shortcutsPicker.getActionPath = getActionPath;
                shortcutsPicker.setActionPath = setActionPath;
                shortcutsPicker.resetActionPath = resetActionPath;
                shortcutsPicker.openerDelegate = tasksShortcutDelegate;
                shortcutsPicker.open();
            }
        }

        ShortcutsPickerSidebar {
            id: shortcutsPicker
            property Item openerDelegate: null
            onClosed: {
                if (openerDelegate) {
                    openerDelegate.forceActiveFocus();
                } else {
                    homeOverlayShortcut.forceActiveFocus();
                }
            }
        }

        DeviceTimeSettingsSidebar {
            id: deviceTimeSettings
            onClosed: timeDateDelegate.forceActiveFocus()
        }
    }
}
