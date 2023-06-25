import 'package:flutter/material.dart';
import 'package:manga_reader/constants/constants.dart';

import 'MangaCard.dart';

class MangaList extends StatelessWidget {
  final List<Map<String, dynamic>> mangaList;
  final List<Map<String, dynamic>> mangaUrlList;

  const MangaList({Key key, this.mangaList, this.mangaUrlList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: double.infinity,
      color: Constants.balck,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Wrap(
          runSpacing: 10,
          spacing: 5,
          children: [
            Container(
              width: double.infinity,
              height: 50,
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Шилдэг ${mangaList.length} Манганууд",
                style: TextStyle(
                  fontSize: 23,
                  color: Color.fromARGB(255, 63, 61, 61),
                ),
              ),
            ),
            for (int i = 0; i < mangaList.length; i++)
              MangaCard(
                mangaImg: mangaList[i]['attributes']['src'],
                mangaTitle: mangaList[i]['attributes']['alt'],
                mangaUrlList: mangaUrlList[i]['attributes']['href'],
              ),
              
          ],
        ),
      ),
    );
  }
}
