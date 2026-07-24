class AudioFiles {

static List<String> getPlaylist(){
  List<String> list = [];
  for (var i = 1; i < 58; i++) {
    list.add('asset/audio/Track_$i.ogg');
  }
  return list;
}

}