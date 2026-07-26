/*
    SPDX-FileCopyrightText: 2020 Noah Davis <noahadvs@gmail.com>

    SPDX-License-Identifier: GPL-2.0-or-later
*/

import QtQuick
import QtMultimedia
import Qt.labs.platform

import org.kde.bigscreen.shell as BigscreenShell

pragma Singleton

QtObject {
    id: navigationSoundEffects

    property bool inConsoleScreen: false

    property SoundEffect clickedSound
    property SoundEffect movingSound
    property SoundEffect clickedSoundGame
    property SoundEffect movingSoundGame
    property SoundEffect ambientSoundGame

    readonly property Component clickedSoundComponent: SoundEffect {
        source: StandardPaths.locate(StandardPaths.GenericDataLocation, "sounds/plasma-bigscreen/clicked.wav")
    }

    readonly property Component movingSoundComponent: SoundEffect {
        source: StandardPaths.locate(StandardPaths.GenericDataLocation, "sounds/plasma-bigscreen/moving.wav")
    }

    readonly property Component clickedSoundGameComponent: SoundEffect {
        source: StandardPaths.locate(StandardPaths.GenericDataLocation, "sounds/plasma-bigscreen/clicked.wav")
    }

    readonly property Component movingSoundGameComponent: SoundEffect {
        source: StandardPaths.locate(StandardPaths.GenericDataLocation, "sounds/plasma-bigscreen/movingGame.wav")
    }

    readonly property Component ambientSoundGameComponent: SoundEffect {
        source: StandardPaths.locate(StandardPaths.GenericDataLocation, "sounds/plasma-bigscreen/ambientSound.wav")
    }

    function stopNavigationSounds() {
        if (!BigscreenShell.Settings.navigationSoundEnabled) {
            return;
        }
        if (clickedSound && clickedSound.playing) {
            clickedSound.stop();
        }
        if (movingSound && movingSound.playing) {
            movingSound.stop();
        }
        if (clickedSoundGame && clickedSoundGame.playing) {
            clickedSoundGame.stop();
        }
        if (movingSoundGame && movingSoundGame.playing) {
            movingSoundGame.stop();
        }
    }

    function stopAmbientSound() {
        if (!BigscreenShell.Settings.ambientSoundEnabled) {
            return;
        }
        if (ambientSoundGame && ambientSoundGame.playing) {
            ambientSoundGame.stop();
        }
    }

    function playClickedSound() {
        if (!BigscreenShell.Settings.navigationSoundEnabled) {
            return;
        }
        if(inConsoleScreen){
            if (!clickedSoundGame) {
                clickedSoundGame = clickedSoundGameComponent.createObject(navigationSoundEffects);
            }
            clickedSoundGame.play();
            return;
        }
        if (!clickedSound) {
            clickedSound = clickedSoundComponent.createObject(navigationSoundEffects);
        }
        clickedSound.play();
    }

    function playMovingSound() {
        if (!BigscreenShell.Settings.navigationSoundEnabled) {
            return;
        }
        if(inConsoleScreen){
            if (!movingSoundGame) {
                movingSoundGame = movingSoundGameComponent.createObject(navigationSoundEffects);
            }
            movingSoundGame.play();
            return;
        }
        if (!movingSound) {
            movingSound = movingSoundComponent.createObject(navigationSoundEffects);
        }
        movingSound.play();
    }

    function playAmbientSound() {
        if (!BigscreenShell.Settings.ambientSoundEnabled) {
            return;
        }
        if (!ambientSoundGame) {
            ambientSoundGame = ambientSoundGameComponent.createObject(navigationSoundEffects);
        }
        ambientSoundGame.play();
    }
}
