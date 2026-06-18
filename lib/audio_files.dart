class AudioFiles {

static List<String> getPlaylist(){
  List<String> list = [];
  for (var i = 1; i < 43; i++) {
    list.add('asset/audio/Track_$i.mp3');
  }
  return list;
}

}