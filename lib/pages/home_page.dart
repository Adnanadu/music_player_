import 'package:flutter/material.dart';
import 'package:music_player/componenets/my_drawer.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:music_player/model/song.dart';
import 'package:music_player/pages/song_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PlaylistProvider playlistProvider;
  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void gotoSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;
    //Navigate to Song Page

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text("P L A Y L I S T"),
      ),
      drawer: MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // get PlayList
              final Song song = playlist[index];

              //return Ui
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(
                  song.albumArtImagePath,
                  width: 80,
                ),
                onTap: () => gotoSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
