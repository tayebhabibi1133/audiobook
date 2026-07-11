
import 'package:audiobook/audio_files.dart';
import 'package:just_audio/just_audio.dart';


class AudioPlayerServices {
 static final AudioPlayer _player = AudioPlayer();
static Stream<Duration> get positionStream => _player.positionStream;
static  Duration? get durationStream => _player.duration;
 static Stream<PlayerState> get playerStateStream => _player.playerStateStream;
static  Stream<SequenceState?> get sequenceStateStream => _player.sequenceStateStream;



static Future<void> loadAudio(int index)async {
final list = AudioFiles.getPlaylist();
String currentFile = list[index];

 await _player.setAsset(currentFile);
}

static Stream<bool> playingState() {
  return _player.playingStream;
}

static void seek(Duration position) => _player.seek(position);

static Future<void> playHandler() async {
  if (_player.playing) {
    await _player.pause();
  } else if(! _player.playing){
    await _player.play();
  }
}

 static Future<void> playAudio()async{
    await _player.play();
  }


 static void dispose(){
    _player.dispose();
  }


}