import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player/model/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> playlist = [
    Song(
        songName: "s",
        artistName: "neyo",
        albumArtImagePath: "assets/images/3_1.jpg",
        audioPath:
            "assets/audio/3 - Why This Kolaveri Di Official Video _ Dhanush_ Anirudh(MP3_320K).mp3"),
    Song(
        songName: "2",
        artistName: "acid rap",
        albumArtImagePath: "assets/images/3_2.jpg",
        audioPath:
            "assets/audio/3 - Why This Kolaveri Di Official Video _ Dhanush_ Anirudh(MP3_320K).mp3"),
    Song(
        songName: "3",
        artistName: "Asap Rocky",
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

//play athe song
  void play() async {
    final String path = playlist[currentSongIndex!].audioPath;
    await audioPlayer.stop();
    await audioPlayer.play(AssetSource(path));
    isPlaying = true;
    notifyListeners();
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
    if (currentSongIndex != null) {
      //if the current song is not the last song
      if (currentSongIndex! < playlist.length - 1) {
        //play the next song
        currentSongIndex = currentSongIndex! + 1;
        // playSong(currentSongIndex!);
        // play();
      } else {
        //play the first song
        currentSongIndex = 0;
        playSong(currentSongIndex!);
        play();
      }
    }
  }

  void playPreviousSong() async {
    //if morethan 5 seconds have passed, restart the song
    if (currentDuration.inSeconds > 5) {
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

//before 32:53
  int? currentSongIndex;

  /// Play the song at the given index
  void playSong(int newIndex) {
    currentSongIndex = newIndex;
    play();
    notifyListeners();
  }
}
