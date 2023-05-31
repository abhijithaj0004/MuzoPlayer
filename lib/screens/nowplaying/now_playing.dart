import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:muzo/screens/allsongs/allsongs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 211, 208, 255),
      body: player.builderCurrent(builder: (context, playing) {
        ValueNotifier<bool> isLoopOn = ValueNotifier(false);
        ValueNotifier<bool> isShuffleOn = ValueNotifier(false);
        ValueNotifier<bool> isFavOn = ValueNotifier(false);

        int id = int.parse(playing.audio.audio.metas.id!);
        return ListView(
          physics: ScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(300)),
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 108, 99, 255),
                    Color.fromARGB(85, 107, 99, 255),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                            Text(
                              'NOW PLAYING',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'KumbhSans',
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                                width: 300,
                                child: Marquee(
                                  text: playing.audio.audio.metas.title
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'KumbhSans'),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 20.0,
                                  velocity: 50.0,
                                  pauseAfterRound: Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:
                                      Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                playing.audio.audio.metas.artist.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 225, 216, 216),
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'KumbhSans',
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    // child: SizedBox(
                    //   width: 170,
                    //   height: 170,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(100),
                    //     child: Image.asset(
                    //       'assets/images/caucasian-woman-s-portrait-isolated-blue-background-multicolored-neon-light.jpg',
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    child: QueryArtworkWidget(
                      id: id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: 170,
                      artworkHeight: 170,
                      artworkFit: BoxFit.cover,
                      artworkBorder: BorderRadius.circular(100),
                      nullArtworkWidget: SizedBox(
                        width: 170,
                        height: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/filip-5LhSaUDgtZ8-unsplash.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  PlayerBuilder.currentPosition(
                      player: player,
                      builder: (context, duration) {
                        return ProgressBar(
                          onSeek: (value) {
                            player.seek(value);
                          },
                          progress: duration,
                          total: player.current.value!.audio.duration,
                          barHeight: 10,
                          thumbRadius: 10,
                          thumbColor: Colors.white,
                          baseBarColor: Color.fromARGB(255, 188, 184, 249),
                          progressBarColor: Color.fromARGB(255, 143, 136, 239),
                        );
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await player.previous();
                        },
                        child: Icon(
                          Icons.skip_previous,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      player.builderIsPlaying(builder: (context, isplaying) {
                        return InkWell(
                          onTap: () async {
                            await player.playOrPause();
                          },
                          child: Icon(
                            isplaying ? Icons.pause_circle : Icons.play_circle,
                            color: Colors.white,
                            size: 80,
                          ),
                        );
                      }),
                      InkWell(
                        onTap: () async {
                          await player.next();
                        },
                        child: Icon(
                          Icons.skip_next,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          if (isShuffleOn.value) {
                            isShuffleOn.value = false;
                            isShuffleOn.notifyListeners();
                          } else {
                            isShuffleOn.value = true;
                            isShuffleOn.notifyListeners();
                          }
                          player.shuffle;
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ValueListenableBuilder(
                              valueListenable: isShuffleOn,
                              builder: (context, shuffleOn, child) {
                                if (!shuffleOn) {
                                  return Icon(
                                    Icons.shuffle,
                                    color: Colors.black,
                                  );
                                } else {
                                  return Icon(
                                    Icons.shuffle,
                                    color: Color.fromARGB(255, 106, 87, 255),
                                  );
                                }
                              }),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (isLoopOn.value) {
                            isLoopOn.value = false;
                            isLoopOn.notifyListeners();
                          } else {
                            isLoopOn.value = true;
                            isLoopOn.notifyListeners();
                          }
                          await player.toggleLoop();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ValueListenableBuilder(
                              valueListenable: isLoopOn,
                              builder: (context, loopOn, child) {
                                if (!loopOn) {
                                  return Icon(
                                    Icons.repeat,
                                    color: Colors.black,
                                  );
                                } else {
                                  return Icon(
                                    Icons.repeat,
                                    color: Color.fromARGB(255, 106, 87, 255),
                                  );
                                }
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (isFavOn.value) {
                            isFavOn.value = false;
                            isFavOn.notifyListeners();
                          } else {
                            isFavOn.value = true;
                            isFavOn.notifyListeners();
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: ValueListenableBuilder(
                            valueListenable: isFavOn,
                            builder: (context, favOn, child) {
                              if (!favOn) {
                                return Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                );
                              } else {
                                return Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 106, 87, 255),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
