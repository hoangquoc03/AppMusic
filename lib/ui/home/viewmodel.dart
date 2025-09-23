import 'dart:async';

import 'package:my_app/data/model/song.dart';
import 'package:my_app/data/respository/respository.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();

  void loadSongs() {
    final repository = DefaultRepository();
    repository.loadData().then((value) => songStream.add(value!));
  }
}