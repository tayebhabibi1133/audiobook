import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 6,
        mainAxisAlignment: .center,
        children: [
          Text('معتصم'),
          Text('روشنگران')

          
        ],
      ),
    );
  }
}