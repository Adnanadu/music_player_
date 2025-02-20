import 'package:flutter/material.dart';
import 'package:music_player/componenets/neu_box.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

//convert duration into min:sec
  String formatTime(Duration duration) {
    String twoDigitSeconds = duration.inSeconds.remainder(60).toString();

    String formattedTime = "${duration.inMinutes.toString()}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final playlist = value.playlist;

      //get current song
      final currentSong = playlist[value.currentSongIndex ?? 0];
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //apbar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back)),
                    //title
                    Text("P L A Y L I S T"),

                    //menu Button
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),

                //album art
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(currentSong.albumArtImagePath)),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(currentSong.artistName),
                              ],
                            ),

                            //heart Icon
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),

                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Start Time
                          Text(formatTime(value.currentDuration)),
                          //Shuffle Button
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.shuffle)),

                          //Repeat Button
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.repeat)),

                          //End Time
                          Text(formatTime(value.totalDuration)),
                        ],
                      ),
                    ),
                    //song duration progress
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 0),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        inactiveColor: Colors.grey,
                        activeColor: Colors.blue,
                        onChanged: (double double) {
                          // value.seek(Duration(seconds: double.toInt()));
                        },
                        onChangeEnd: (double double) {
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                //plyaback controls
                Row(
                  spacing: 20,
                  children: [
                    //skip Previous Button
                    Expanded(
                        child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: NeuBox(child: Icon(Icons.skip_previous)))),

                    //Play & Pause Button
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                                child: Icon(
                              value.isPlaying ? Icons.pause : Icons.play_arrow,
                            )))),

                    //Skip Next Button
                    Expanded(
                        child: GestureDetector(
                            onTap: value.playNextSong,
                            child: NeuBox(child: Icon(Icons.skip_next)))),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
