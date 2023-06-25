import 'package:flutter/material.dart';
import 'package:manga_reader/constants/constants.dart';
import 'package:manga_reader/screens/ContentScreen.dart';

class MangaChapters extends StatelessWidget {
  final List<Map<String, dynamic>> mangaChapters;
final String mangaTitle;
  const MangaChapters({Key key, this.mangaChapters, this.mangaTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mangaChapters.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 60,
            width: double.infinity,
            child: Material(
              color: Constants.lightgray,
              child: InkWell(
                onTap: () { 
                  print(mangaChapters[index]['attributes']['href']);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContentScreen(
                        // mangaImg: mangaImg,
                        mangaLink: mangaChapters[index]['attributes']['href'],
                        mangaTitle: mangaTitle,
                      ),
                    ),
                  );                  
                 },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 5.0), // (8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      mangaChapters[index]['title'].toString().trim(),
                      style: TextStyle(color: Colors.white, fontSize: 14, ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}