import 'package:flutter/material.dart';
import 'package:muzo/screens/playlist/playlist.dart';
import 'package:muzo/screens/topbeats/topbeats.dart';
import 'package:muzo/screens/welcomescreens/login.dart';
import 'package:muzo/widgets/home_screen_widgets/image_card.dart';
import 'package:muzo/widgets/home_screen_widgets/music_list_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> recentList = ValueNotifier([]);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = userNameController.text.trim();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * .02,
        MediaQuery.of(context).size.height * .02,
        MediaQuery.of(context).size.width * .02,
        MediaQuery.of(context).size.height * .02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .76,
              MediaQuery.of(context).size.height * .0,
              MediaQuery.of(context).size.width * 0,
              MediaQuery.of(context).size.height * 0,
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'KumbhSans',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    username.isEmpty ? 'Guest' : username,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'KumbhSans',
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PlayList()));
                },
                child: imageCard(context,
                    title: 'Playlists',
                    image:
                        'assets/images/caucasian-woman-s-portrait-isolated-blue-background-multicolored-neon-light.jpg'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TopBeats()));
                },
                child: imageCard(context,
                    title: 'Top Beats',
                    image:
                        'assets/images/close-up-musical-keys-indoors-with-beautiful-lighting.jpg'),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .063,
              MediaQuery.of(context).size.height * .02,
              MediaQuery.of(context).size.width * 0,
              MediaQuery.of(context).size.height * 0,
            ),
            child: const Text(
              'Recently Played',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'KumbhSans',
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: MusicListTile())
        ],
      ),
    );
  }
}
