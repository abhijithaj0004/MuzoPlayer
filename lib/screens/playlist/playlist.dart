import 'package:flutter/material.dart';
import 'package:muzo/functions/dbfunctions/playlist_db.dart';
import 'package:muzo/screens/playlist/inside_the_playlist.dart';

class PlayList extends StatelessWidget {
  PlayList({super.key});
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getAllPlaylist();
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 108, 99, 255),
                Color.fromARGB(79, 107, 99, 255),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(400))),
        ),
        Positioned(
          top: 50,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  )),
              SizedBox(
                width: 100,
              ),
              const Text(
                'PLAYLISTS',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'KumbhSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 100, right: 20),
          child: ValueListenableBuilder(
              valueListenable: playList,
              builder: (context, playlistValue, child) {
                if (playlistValue.isEmpty) {
                  return Center(
                    child: Text(
                      'No playlist found',
                    ),
                  );
                }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 90,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color.fromARGB(255, 203, 203, 203),
                              Color.fromARGB(0, 207, 207, 207),
                            ]),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InsidePlaylist(),
                              ));
                            },
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
                            title: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                playlistValue[index].playListName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'KumbhSans'),
                              ),
                            ),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              onSelected: (value) {
                                value == 1
                                    ? showDialog(
                                        context: context,
                                        builder: ((context) {
                                          return AlertDialog(
                                            title: Text('EDIT PLAYLIST NAME'),
                                            content: TextFormField(
                                              controller: editController,
                                              decoration: InputDecoration(
                                                  hintText: 'Playlist Name'),
                                            ),
                                            actions: [
                                              TextButton.icon(
                                                  onPressed: () async {
                                                    await updatePlaylistname(
                                                        editController.text
                                                            .trim(),
                                                        playlistValue[index]);

                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.check_sharp,
                                                    color: Colors.green,
                                                  ),
                                                  label: Text(
                                                    'SUMBIT',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15),
                                                  )),
                                            ],
                                          );
                                        }))
                                    : playListPopUp(
                                        context, playlistValue[index].key);
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                  PopupMenuItem(
                                    child: Text('Rename'),
                                    value: 1,
                                  ),
                                  PopupMenuItem(
                                    child: Text('Remove Playlist'),
                                    value: 2,
                                  ),
                                ];
                              },
                            ),
                          ),
                        ));
                  },
                  itemCount: playlistValue.length,
                );
              }),
        )
      ]),
    );
  }

  Future<dynamic> playListPopUp(BuildContext context, int play) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text('PLEASE CONFIRM DELETION'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        deletePlaylist(play);

                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      label: Text(
                        'YES',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                  TextButton.icon(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.close_sharp,
                        color: Colors.red,
                      ),
                      label: Text(
                        'NO',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))
                ],
              ),
            ],
          );
        }));
  }
}
