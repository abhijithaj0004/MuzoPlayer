import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzo/model/playlistmodel/playlist_model.dart';

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
}

deletePlaylist(int id) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  await playlistDb.delete(id);
  print('is it worikig');
  await getAllPlaylist();
}

updatePlaylistname(String newName, PlayListModel oldPlayList) async {
  final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
  PlayListModel newPlayList =
      PlayListModel(playListName: newName, playlistId: oldPlayList.playlistId);
  await playlistDb.put(oldPlayList.key, newPlayList);
  getAllPlaylist();
}
