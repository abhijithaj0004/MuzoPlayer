// ignore_for_file: must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:muzo/functions/normalfunctions/playSong.dart';
import 'package:muzo/functions/normalfunctions/song_model_to_audio.dart';
import 'package:muzo/screens/allsongs/allsongs.dart';
import 'package:muzo/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<SongModel>> playListNotifier = ValueNotifier([]);

class InsidePlaylist extends StatelessWidget {
 late List<Audio> playListSongList = [];
  InsidePlaylist({super.key});
  @override
  Widget build(BuildContext context) {
    playListSongList = convertToAudio(playListNotifier.value);
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.5,
          decoration:const BoxDecoration(
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
           const   SizedBox(
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
              valueListenable: playListNotifier,
              builder: (context, playlistvalue, _) {
                return ListView.builder(
                  physics:const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        margin:const EdgeInsets.only(bottom: 20),
                        height: 90,
                        decoration: BoxDecoration(
                            gradient:const LinearGradient(colors: [
                              Color.fromARGB(255, 203, 203, 203),
                              Color.fromARGB(0, 207, 207, 207),
                            ]),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: ListTile(
                            onTap: () {
                              playSong(playListSongList, index);
                              showBottomSheet(
                                enableDrag: false,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return player.builderCurrent(
                                    builder: (context, playing) {
                                      return MiniPlayer(
                                        index: index,
                                      );
                                    },
                                  );
                                },
                              );
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
                            title:const Padding(
                              padding:  EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Heat-Waves...',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'KumbhSans'),
                              ),
                            ),
                            subtitle:const Padding(
                              padding:  EdgeInsets.only(left: 10.0),
                              child: Text('<Unknown>'),
                            ),
                            trailing: PopupMenuButton(
                              icon:const Icon(Icons.more_vert),
                              onSelected: (value) {
                                playListPopUp(context);
                              },
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                const  PopupMenuItem(
                                  
                                    value: 0,
                                      child:  Text('Remove'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ));
                  },
                  itemCount: playlistvalue.length,
                );
              }),
        )
      ]),
    );
  }

  Future<dynamic> playListPopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title:const Text('PLEASE CONFIRM DELETION'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                      onPressed: () {
                       
                        Navigator.of(context).pop();
                      },
                      icon:const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      label:const Text(
                        'YES',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )),
                  TextButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon:const Icon(
                        Icons.close_sharp,
                        color: Colors.red,
                      ),
                      label:const Text(
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
