import 'package:flutter/material.dart';
import 'package:music_player/componenets/neu_box.dart';
import 'package:music_player/model/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) => Scaffold(
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
                    IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                    //title
                    Text("P L A Y L I S T"),

                    //menu Button
                    IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  ],
                ),

                //album art
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset("assets/images/3_1.jpg")),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "So Sick",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Neyo"),
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
                          Text("0:00"),
                          //Shuffle Button
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.shuffle)),

                          //Repeat Button
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.repeat)),

                          //End Time
                          Text("3:30"),
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
                        max: 100,
                        value: 50,
                        inactiveColor: Colors.grey,
                        activeColor: Colors.blue,
                        onChanged: (value) {},
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
                            onTap: () {},
                            child: NeuBox(child: Icon(Icons.skip_previous)))),

                    //Play & Pause Button
                    Expanded(
                        flex: 2,
                        child: GestureDetector(
                            onTap: () {},
                            child: NeuBox(child: Icon(Icons.play_arrow)))),

                    //Skip Next Button
                    Expanded(
                        child: GestureDetector(
                            onTap: () {},
                            child: NeuBox(child: Icon(Icons.skip_next)))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
