import 'dart:async';

import 'package:audiobook/audio_files.dart';
import 'package:audiobook/services/audio_player.dart';
import 'package:audiobook/services/volume_controller.dart';
import 'package:flutter/material.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.index});
  final int index;
  

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  double volumeValue = 0;
  late final StreamSubscription<double> _subscription;
  @override
  void initState() {
    int currentIndex = widget.index + 1;
    super.initState();
    if (currentIndex < 10) {
     AudioPlayerServices.loadAudio('asset/audio/Track_$currentIndex.mp3'); 
    }
    AudioPlayerServices.playAudio();
   _subscription = VolumeControl.controller.addListener((value) {
      setState(() {
        volumeValue = value;
      });
    },);
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = widget.index + 1;
    return Scaffold(
      appBar: AppBar(title: Text('درس $currentIndex')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            StreamBuilder<Duration>(
              stream: AudioPlayerServices.positionStream,
              builder: (context, snapshot) {
                String formatDuration(Duration d) {
                  final minutes = d.inMinutes
                      .remainder(60)
                      .toString()
                      .padLeft(2, '0');
                  final seconds = d.inSeconds
                      .remainder(60)
                      .toString()
                      .padLeft(2, '0');
                  return "$minutes:$seconds";
                }

                final position = snapshot.data ?? Duration.zero;
                final total =
                    AudioPlayerServices.durationStream ?? Duration.zero;

                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(formatDuration(position)),
                          Text(formatDuration(total)),
                        ],
                      ),
                    ),
                    Slider(
                      activeColor: Colors.green,
                      value: position.inMilliseconds.toDouble().clamp(
                        0,
                        total.inMilliseconds.toDouble(),
                      ),
                      min: 0,
                      max: total.inMilliseconds.toDouble(),
                      onChanged: (value) {
                        AudioPlayerServices.seek(
                          Duration(milliseconds: value.toInt()),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: .center,
              children: [
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    widget.index != 0
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlayerPage(index: widget.index - 1);
                              },
                            ),
                          )
                        : null;
                  },
                  icon: Icon(Icons.skip_previous_rounded),
                ),
                StreamBuilder(
                  stream: AudioPlayerServices.playingState(),
                  builder: (context, snapshot) {
                    final isPlaying = snapshot.data ?? false;
                    return IconButton(
                      iconSize: 70,
                      onPressed: () async {
                        await AudioPlayerServices.playHandler();
                      },
                      icon: Icon(
                        isPlaying
                            ? Icons.pause_circle_outline_rounded
                            : Icons.play_circle_outline_rounded,
                      ),
                    );
                  },
                ),
                IconButton(
                  iconSize: 50,
                  onPressed: () {
                    widget.index == AudioFiles.getPlaylist().length - 1
                        ? null
                        : Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PlayerPage(index: widget.index + 1);
                              },
                            ),
                          );
                  },
                  icon: Icon(Icons.skip_next_rounded),
                ),
              ],
            ),
            Slider(value: volumeValue, onChanged: (value) async{
              await VolumeControl.setVolume(value);
            },)
          ],
        ),
      ),
    );
  }
}
