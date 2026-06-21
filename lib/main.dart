
import 'package:audiobook/about_page.dart';
import 'package:audiobook/contact_page.dart';
import 'package:audiobook/lists.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

late AudioPlayer audioPlayer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  audioPlayer = AudioPlayer();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 251, 245, 211),
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          spacing: 20,
          mainAxisAlignment: .spaceEvenly,
          children: [
            Placeholder(fallbackHeight: 200),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 10,
                mainAxisAlignment: .center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(255, 208, 0, 1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return AboutPage();
                      },));
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.info_outline_rounded),
                        Text("درباره ما"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(255, 208, 0, 1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ContactPage();
                      },));
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.perm_contact_calendar),
                        Text('ارتباط با ما'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(0, 150, 35, 1),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListsWidget()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.navigate_next_rounded),
                        Text('صفحه بعد'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
