import 'package:audiobook/audio_files.dart';
import 'package:audiobook/player_page.dart';
import 'package:flutter/material.dart';

class ListsWidget extends StatefulWidget {
  const ListsWidget({super.key});

  @override
  State<ListsWidget> createState() => _ListsWidgetState();
}

class _ListsWidgetState extends State<ListsWidget> {
  List<String> list = AudioFiles.getPlaylist();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('دروس')),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 3, spreadRadius: 1)],
                color: Colors.green.shade400,
                borderRadius: .circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: ListTile(title: Text('درس ${index + 1}'),onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PlayerPage(index: index,);
              },))),);
          },
        ),
      );
  }
}
