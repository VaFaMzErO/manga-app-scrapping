import 'package:flutter/material.dart';
import 'package:manga_reader/constants/constants.dart';

class MangaInfoBtn extends StatelessWidget {
  final IconData icon;
  final String title;

  const MangaInfoBtn({Key key, this.icon, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Color.fromARGB(255, 58, 139, 220),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}