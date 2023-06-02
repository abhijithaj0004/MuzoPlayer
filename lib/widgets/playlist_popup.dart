import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muzo/functions/dbfunctions/playlist_db.dart';
import 'package:muzo/model/playlistmodel/playlist_model.dart';
import 'package:muzo/screens/allsongs/allsongs.dart';

class PlayListPopUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final int songId;
  PlayListPopUp({super.key, required this.songId});
  TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 108, 99, 255),
            Color.fromARGB(79, 107, 99, 255),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(70),
              bottomRight: Radius.circular(400))),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            const Text(
              'ADD TO PLAYLIST',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'KumbhSans'),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 3, color: Colors.white)),
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Add New PLaylist'),
                        content: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: playlistController,
                            decoration:
                                const InputDecoration(hintText: 'PlaylistName'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter PlayListName';
                              }
                              return null;
                            },
                          ),
                        ), 
                        actions: [
                          TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );

                                PlayListModel newPlaylist = PlayListModel(
                                    playListName:
                                        playlistController.text.trim(),
                                    playlistId: []);

                                createPlayList(newPlaylist);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, bottom: 20),
              width: double.infinity,
              child: const Text(
                'Playlists',
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: 'KumbhSans'),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: playList,
                  builder: (context, playlistBuild, child) {
                    return ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 80,
                          child: ListTile(
                            onTap: () {
                              addToPlaylistDb(
                                  songId, playlistBuild[index].playListName);
                            },
                            title: Text(
                              playlistBuild[index].playListName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'KumbhSans'),
                            ),
                            leading: SizedBox(
                              width: 50,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  'assets/images/filip-5LhSaUDgtZ8-unsplash.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: playlistBuild.length,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
