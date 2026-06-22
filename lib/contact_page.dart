import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://t.me/ISLAM_AudioBooks');

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          child: Text(
            'کانال تلگرام ما',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 30,
              decoration: TextDecoration.combine([TextDecoration.underline]),
              decorationColor: Colors.blue,
            ),
          ),
          onTap: () => launchUrl(url),
        ),
      ),
    );
  }
}
