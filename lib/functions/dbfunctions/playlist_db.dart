import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzo/model/playlistmodel/playlist_model.dart';
import 'package:muzo/screens/allsongs/allsongs.dart';
import 'package:muzo/screens/playlist/inside_the_playlist.dart';

ValueNotifier<List<PlayListModel>> playList = ValueNotifier([]);
createPlayList(PlayListModel newPlaylist) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  await playlistDb.add(newPlaylist);
  getAllPlaylist();
}

getAllPlaylist() async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  playList.value.clear();
  playList.value.addAll(playlistDb.values);
  playList.notifyListeners();
  for (var i = 0; i < playList.value.length; i++) {
    log('${playList.value[i].playlistId}');
    // for (var j = 0; j < playList.value[i].playlistId!.length; j++) {
    //   log('${playList.value[i].playlistId![j]} jkhjhjhgjhjghg');
    // }
  }
}

deletePlaylist(int id) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  await playlistDb.delete(id);
  await getAllPlaylist();
}

updatePlaylistname(String newName, PlayListModel oldPlayList) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  PlayListModel newPlayList =
      PlayListModel(playListName: newName, playlistId: oldPlayList.playlistId);
  await playlistDb.put(oldPlayList.key, newPlayList);
  getAllPlaylist();
}

addToPlaylistDb(int id, String playlistName) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  for (var element in playlistDb.values) {
    if (element.playListName == playlistName) {
      var key = element.key;
      PlayListModel updatePlaylistamodel =
          PlayListModel(playListName: playlistName);
      updatePlaylistamodel.playlistId?.addAll(element.playlistId!);
      updatePlaylistamodel.playlistId?.add(id);
      playlistDb.put(key, updatePlaylistamodel);
    }
  }
  getAllPlaylist();
}

getAllPlaylistSongs(String playListName) async {
  List<int> playListSongId = [];
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  for (var element in playlistDb.values) {
    if (element.playListName == playListName) {
      log(element.playlistId!.length.toString());
      playListSongId.addAll(element.playlistId!);
    }
  }
  for (var i = 0; i < allsongs.length; i++) {
    for (var j = 0; j < playListSongId.length; j++) {
      if (allsongs[i].id == playListSongId[j].toString()) {
        playListNotifier.value.add(allsongs[i]);
      }
    }
  }
}
