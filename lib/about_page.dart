import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          spacing: 6,
          mainAxisAlignment: .center,
          children: [
            Text('معتصم', style: TextStyle(fontSize: 30)),
            Text('روشنگران', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
