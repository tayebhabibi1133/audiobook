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
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 3, spreadRadius: 1)],
              color: Colors.green.shade400,
              borderRadius: .circular(15),
            ),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text('درس ${index + 1}'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return index == 9
                        ? DisclaimerPage()
                        : PlayerPage(index: index);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DisclaimerPage extends StatelessWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: .all(15),
          child: Column(
            mainAxisAlignment: .center,
            spacing: 5,
            children: [
              Text('''
        درس های نظام سیاسی تکمیل نیست چون استاد را بعد از درس نهم ترور کردند.

        الله متعال از خطا های استاد بگذرد و بر حسنات شان بیفزاید.

        شما میتوانید جهت فهم بیشتر به منابع معتبر دیگر سر بزنید.
        ''', style: TextStyle(fontSize: 20,), textDirection: .rtl,)
              // Text(
              //   'درس های نظام سیاسی تکمیل نیست چون استاد را بعد از درس نهم ترور کردند',
              // ),
              // Text('الله متعال از خطا های استاد بگذرد و بر حسنات شان بیفزاید'),
              // Text('شما میتوانید جهت فهم بیشتر به منابع معتبر دیگر سر بزنید'),
            ],
          ),
        ),
      ),
    );
  }
}
