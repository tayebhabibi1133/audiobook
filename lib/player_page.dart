import 'dart:async';
import 'dart:convert';

import 'package:audiobook/audio_files.dart';
import 'package:audiobook/services/audio_player.dart';
import 'package:audiobook/services/volume_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key, required this.index});
  final int index;
  

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  double fontSize = 15;
  double volumeValue = 0;
  late final StreamSubscription<double> _subscription;
  @override
  void initState() {
    super.initState();
    AudioPlayerServices.loadAudio(widget.index);
    AudioPlayerServices.playAudio();
   _subscription = VolumeControl.controller.addListener((value) {
      setState(() {
        volumeValue = value;
      });
    },);
  }

void changeFontSize({required double newValue}){
fontSize = newValue;
setState(() {});
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
          mainAxisAlignment: .spaceAround,
          children: [
            TextReader(fontSize: fontSize, index: currentIndex,),
            StreamBuilder(stream: Stream.value(fontSize), builder: (context, snapshot) {
              return Slider(min: 1,max: 50,
              value: fontSize, onChanged: (value){
              changeFontSize(newValue: value);
            });
            },),
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


class TextReader extends StatefulWidget {
  const TextReader({super.key, required this.fontSize, required this.index});
  final double fontSize;
  final int index;
  @override
  State<TextReader> createState() => _TextReaderState();
}

class _TextReaderState extends State<TextReader> {
String displayText = '';
bool isLoading = true;

@override
  void initState() {
    super.initState();
    readJsonFile();
  }

Future<void> readJsonFile() async {
  try {
    String jsonString = await rootBundle.loadString('asset/text/text_file.json');
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  setState(() {
    displayText = jsonData['text_${widget.index}'];
    isLoading = displayText == '' ? true : false;
  });
  } catch (e) {
    setState(() {
      displayText = e.toString();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.sizeOf(context).height;
    double deviceWidth = MediaQuery.sizeOf(context).width;
    return Container(
      padding: .symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black),
          BoxShadow(
            color:  Color.fromARGB(255, 251, 245, 211),
            spreadRadius: -2,
            blurRadius: 10
          )
        ],
        border: Border.all(
          color: Colors.green,
          width: 3
        ),
        borderRadius: .circular(30),
      ),
      margin: .all(10),
      height: deviceHeight * 0.5,
      width: deviceWidth,
      child: SingleChildScrollView(
        child: isLoading ? Center(child: CircularProgressIndicator()) :
        SelectableText('''

$displayText

''', textDirection: .rtl, style: TextStyle(fontSize: widget.fontSize,),
      ),
      
    ));
  }
}