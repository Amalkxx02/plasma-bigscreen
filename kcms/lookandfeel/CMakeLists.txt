# SPDX-FileCopyrightText: 2019 Marco Martin <mart@kde.org>
# SPDX-FileCopyrightText: 2019 Aditya Mehra <aix.m@outlook.com>
# SPDX-License-Identifier: GPL-2.0-or-later

set(bigscreenlookandfeel_SRCS
    bigscreenlookandfeel.cpp bigscreenlookandfeel.h
    colorschemelistmodel.cpp colorschemelistmodel.h
)

kcmutils_add_qml_kcm(kcm_mediacenter_bigscreen_lookandfeel SOURCES ${bigscreenlookandfeel_SRCS})

target_link_libraries(kcm_mediacenter_bigscreen_lookandfeel
    Qt::DBus
    Qt::Gui
    Qt::Quick
    Qt::Qml
    KF6::ConfigCore
    KF6::Svg
    Plasma::Plasma
    KF6::I18n
    KF6::KCMUtilsQuick
    KF6::ColorScheme
    KF6::CoreAddons
)
