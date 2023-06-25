import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/components/detailScreen/MangaChapter.dart';
import 'package:manga_reader/components/detailScreen/MangaDesc.dart';
import 'package:manga_reader/components/detailScreen/MangaInfo.dart';
import 'package:manga_reader/constants/constants.dart';
import 'package:manga_reader/widgets/HorDivider.dart';
import 'package:web_scraper/web_scraper.dart';

class DetailScreen extends StatefulWidget {
  final String mangaImg, mangaTitle, mangaLink;

  const DetailScreen({Key key, this.mangaImg, this.mangaTitle, this.mangaLink})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String mangaGenres, mangaStatus, mangaAuthor, mangaDesc;
  // mangaLink = https://www.mngdoom.com/wan-gu-shen-wang
  List<Map<String, dynamic>> mangaDetail;
  List<Map<String, dynamic>> mangaDescList;
  List<Map<String, dynamic>> mangaChapters;
  List<Map<String, dynamic>> mangaStatuScrap;

  bool dataFetch = false;

  void getMangaInfos() async {
    String tempBaseUrl = widget.mangaLink.split(".com")[0] + ".com";
    String tempRoute = widget.mangaLink.split(".com")[1];
print(" tempbaseurl----->");
    print(tempBaseUrl);
    print("temproute----->");
    print(tempRoute);
    final webscraper = WebScraper(tempBaseUrl);

    if (await webscraper.loadWebPage(tempRoute)) {

      mangaDetail = webscraper.getElement(
        'div.content-inner.inner-page > div.row > div.col-md-8 > dl > dd',
        [],
      );

      mangaDescList = webscraper.getElement(
        'div.content-inner.inner-page > div.note.note-default.margin-top-15 ',
        [],
      );

      mangaChapters = webscraper.getElement(
        'div.content > div#chapter_list.content-inner.inner-page > ul > li > a',
        ['href'],
      );
     // mangaAuthor = webscraper.getElement('', []).toString();
    }

   mangaGenres = mangaDetail[2]['title'].toString().trim();
   mangaStatus = mangaDetail[1]['title'].toString().trim();
   mangaAuthor = mangaDetail[4]['title'].toString().trim();
   mangaDesc = mangaDescList[0]['title'].toString().trim();
// print("Manga Detail----->");
//     print(mangaDetail);
  
// print("Manga Desclist----->");
//     print(mangaDescList);

// print("Manga Chapters----->");
//     print(mangaChapters);

    setState(() {
      dataFetch = true;
    });
  
  final FirebaseAuth _authn = FirebaseAuth.instance;
    var currentUser = _authn.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("mangas");
    return _collectionRef.doc(widget.mangaTitle).set({
          "author": mangaAuthor,
          "genres": mangaGenres,
          "desc": mangaDesc,
          "url": widget.mangaLink,

        })
        .then((value) => print("manga added"))
        .catchError((error) => print("something is wrong. $error"));
  }
  

  @override
  void initState() {
    super.initState();
    getMangaInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mangaTitle),
        centerTitle: true,
        backgroundColor: Constants.darkgray,
      ),
      body: dataFetch
          ? Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Constants.lightgray,
              child: Padding(
                padding: EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // mangaInfo - manga img, author, 3 button
                    MangaInfo(
                      mangaImg: widget.mangaImg,
                      mangaStatus: mangaStatus,
                      mangaAuthor: mangaAuthor,
                      mangaLink: widget.mangaLink,
                    ),
                    HorDivier(),
                    // mangaDesc - desc, genre
                    MangaDesc(
                      mangaDesc: mangaDesc,
                      mangaGenres: mangaGenres,
                    ),
                    HorDivier(),
                    // // mangaChapters - chapters
                    MangaChapters(
                      mangaTitle : widget.mangaTitle,
                      mangaChapters: mangaChapters,
                    )
                  ],
                ),
              ),
            ))
          : Center(child: CircularProgressIndicator()),
    );
  }
}