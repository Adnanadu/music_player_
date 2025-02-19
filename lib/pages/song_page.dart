import 'package:flutter/material.dart';
import 'package:music_player/componenets/neu_box.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Song Page"),
      ),
      body: Center(
        child: NeuBox(child: Icon(Icons.search_rounded)),
      ),
    );
  }
}
