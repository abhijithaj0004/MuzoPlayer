import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:muzo/functions/dbfunctions/playlist_db.dart';
import 'package:muzo/model/playlistmodel/playlist_model.dart';

class PlayListPopUp extends StatelessWidget {
  PlayListPopUp({super.key});
  TextEditingController playlistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return Container(
      decoration: BoxDecoration(
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
            Text(
              'ADD TO PLAYLIST',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'KumbhSans'),
            ),
            SizedBox(
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
                        title: Text('Add New PLaylist'),
                        content: TextFormField(
                          controller: playlistController,
                          decoration: InputDecoration(hintText: 'PlaylistName'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              PlayListModel newPlaylist = PlayListModel(
                                  playListName: playlistController.text.trim(),
                                  playlistId: []);

                              createPlayList(newPlaylist);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 20),
              width: double.infinity,
              child: Text(
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
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 80,
                          child: ListTile(
                            title: Text(
                              playlistBuild[index].playListName,
                              style: TextStyle(
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
                            onTap: () {},
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
