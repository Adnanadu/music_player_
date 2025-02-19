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


//before 16 11
  int? currentSongIndex;
  /// Play the song at the given index
  void playSong(int index) {
    currentSongIndex = index;
    notifyListeners();
  }

}
