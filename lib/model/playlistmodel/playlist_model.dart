import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel extends HiveObject {
  @HiveField(0)
  final String playListName;
  @HiveField(1)
  final List<int> playlistId;

  PlayListModel({required this.playListName, required this.playlistId});
}
