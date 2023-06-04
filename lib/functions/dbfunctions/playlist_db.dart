import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:muzo/model/playlistmodel/playlist_class.dart';
import 'package:muzo/model/playlistmodel/playlist_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<EachPlaylist>> playlistNotifier = ValueNotifier([]);
createPlayList(playListName) async {
  playlistNotifier.value.add(EachPlaylist(name: playListName));
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  await playlistDb.put(playListName, PlayListModel(playListName: playListName));
  playlistNotifier.notifyListeners();
}

// getAllPlaylist() async {
//   Box<PlayListModel> playlistDb = await Hive.openBox('play_list_db');
//   playList.value.clear();
//   playList.value.addAll(playlistDb.values);
//   playList.notifyListeners();
// }

// Future playlistAddDB(SongModel addingSong, String playlistName) async {
//   Box<PlayListModel> playlistdb = await Hive.openBox('playlist');

//   for (PlayListModel element in playlistdb.values) {
//     if (element.playListName == playlistName) {
//       var key = element.key;
//       PlayListModel ubdatePlaylist = PlayListModel(playListName: playlistName);
//       ubdatePlaylist.playlistId.addAll(element.playlistId);
//       ubdatePlaylist.playlistId.add(addingSong.id);
//       playlistdb.put(key, ubdatePlaylist);
//       break;
//     }
//   }
// }

deletePlaylist(String PlaylistName) async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  playlistDb.delete(PlaylistName);
  for (EachPlaylist data in playlistNotifier.value) {
    if (data.name == PlaylistName) {
      playlistNotifier.value.remove(data);
      break;
    }
  }
  playlistNotifier.notifyListeners();
}

// updatePlaylistname(String newName, PlayListModel oldPlayList) async {
//   final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
//   // PlayListModel newPlayList =
//   //     PlayListModel(playListName: newName, playlistId: oldPlayList.playlistId);
//   // await playlistDb.put(oldPlayList.key, newPlayList);
//   getAllPlaylist();
// }

songAddToPlaylist(String playlistName, SongModel song) async {
  final Box<PlayListModel> playlistDb =
      await Hive.openBox<PlayListModel>('play_list_db');
  PlayListModel data = playlistDb.get(playlistName)!;
  data.playlistId.add(song.id);
  playlistDb.put(playlistName, data);
  for (EachPlaylist value in playlistNotifier.value) {
    if (value.name == playlistName) {
      value.container.add(song);
      break;
    }
  }
}

// getAllPlaylistSongs(String playListName) async {
//   List<int> playListSongId = [];
//   final playlistDb = await Hive.openBox<PlayListModel>('play_list_db');
//   for (var element in playlistDb.values) {
//     if (element.playListName == playListName) {
//       log(element.playlistId!.length.toString());
//       playListSongId.addAll(element.playlistId!);
//     }
//   }
//   for (var i = 0; i < allsongs.length; i++) {
//     for (var j = 0; j < playListSongId.length; j++) {
//       if (allsongs[i].id == playListSongId[j].toString()) {
//         playListNotifierSongModel.value.add(allsongs[i]);
//       }
//     }
//   }
// }
