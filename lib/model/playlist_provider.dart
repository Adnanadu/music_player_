import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> playlist = [
    Song(
        songName: "Why This Kolaveri Di_1",
        artistName: "Anirudh Ravichander and Dhanush",
        albumArtImagePath: "assets/images/3_1.jpg",
        audioPath:
            "assets/audio/3 - Why This Kolaveri Di Official Video _ Dhanush_ Anirudh(MP3_320K).mp3"),
    Song(
        songName: "Why This Kolaveri Di_2",
        artistName: "Anirudh Ravichander and Dhanush",
        albumArtImagePath: "assets/images/3_2.jpg",
        audioPath:
            "assets/audio/3 - Why This Kolaveri Di Official Video _ Dhanush_ Anirudh(MP3_320K).mp3"),
    Song(
        songName: "Why This Kolaveri Di_3",
        artistName: "Anirudh Ravichander and Dhanush",
        albumArtImagePath: "assets/images/3_3.jpg",
        audioPath:
            "assets/audio/3 - Why This Kolaveri Di Official Video _ Dhanush_ Anirudh(MP3_320K).mp3"),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  //duration
  Duration currentDuration = Duration.zero;
  Duration totalDuration = Duration.zero;

  //Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initally not playing
  bool isPlaying = false;

// Initialize with first song
  int? currentSongIndex = 0;

//play the song
  void play() async {
    try {
      currentSongIndex ??= 1;

      log('Playing song at index: $currentSongIndex');
      final String fullPath = playlist[currentSongIndex!].audioPath;
      final String assetPath = fullPath.replaceFirst('assets/', '');

      log('Asset path: $assetPath');
      await audioPlayer.stop();
      await audioPlayer.play(AssetSource(assetPath));
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      log('Error playing audio: $e');
      isPlaying = false;
      notifyListeners();
    }
  }

  //pause current song
  void pause() async {
    await audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  //resume the song

  void resume() async {
    await audioPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seek to a particular position
  void seek(Duration position) async {
    await audioPlayer.seek(position);
  }

  void playNextSong() {
    if (currentSongIndex == null) {
      currentSongIndex = 0;
    } else {
      currentSongIndex = (currentSongIndex! + 1) % playlist.length;
    }
    playSong(currentSongIndex!);
    log('Playing next song at index: $currentSongIndex');
  }

  void playPreviousSong() async {
    //if morethan 5 seconds have passed, restart the song
    if (currentDuration.inSeconds > 5) {
      seek(Duration.zero);
    } else {
      if (currentSongIndex! > 0) {
        currentSongIndex = currentSongIndex! - 1;
      } else {
        //if its the first song, play the last song
        currentSongIndex = playlist.length - 1;
      }
    }
  }

  //Listen to the duration
  void listenToDuration() {
    // audioPlayer.onDurationChanged.listen((event) {
    //   totalDuration = event;
    //   notifyListeners();
    // });

    /// listen for total duartion

    audioPlayer.onDurationChanged.listen((newDuration) {
      totalDuration = newDuration;
      notifyListeners();
    });

    /// listen for current duration
    audioPlayer.onPositionChanged.listen((newPosition) {
      currentDuration = newPosition;
      notifyListeners();
    });

    /// listen for song completion
    audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  /// Play the song at the given index
  void playSong(int newIndex) {
    currentSongIndex = newIndex;
    play();
    notifyListeners();
  }
}
