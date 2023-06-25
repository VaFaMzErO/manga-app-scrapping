import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/components/homeScreen/MangaList.dart';
import 'package:manga_reader/screens/home/FavoriteScreen.dart';
import 'package:manga_reader/widgets/MangaInfoBtn.dart';
import 'package:manga_reader/widgets/VertDivider.dart';
import 'package:web_scraper/web_scraper.dart';

class Author extends StatefulWidget {
  @override
  // final String mangaImg, mangaStatus, mangaAuthor, mangaLink;

  // const MangaInfo(
  //     {Key key,
  //     this.mangaLink,
  //     this.mangaImg,
  //     this.mangaStatus,
  //     this.mangaAuthor})
  //     : super(key: key);
  _AuthorState createState() => _AuthorState();

void pressFavorite(String mangaLink) async {
  
  final FirebaseAuth _authn = FirebaseAuth.instance;
  var currentUser = _authn.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("user-data");
  return _collectionRef
      .doc(currentUser.email)
      .set({
        "favoritedBooks": null,
      })
      .then((value) => print("user data added"))
      .catchError((error) => print("something is wrong. $error"));
}
}


class _AuthorState extends State<Author> {
  Icon iconv = Icon(Icons.favorite_border_outlined);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 250,
                    width: 220,
                    child: Icon(
                      Icons.person,

                    ),
                  ),
                //   Text("Author : " + mangaAuthor + " \n \t ",
                //       style: TextStyle(
                //         color: Color.fromARGB(255, 214, 205, 205),
                //         fontSize: 15,
                //       ))
                ],
              ),
            ),
          ),
          Container(
            height: 64,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MangaInfoBtn(
                  icon: Icons.play_circle_outline_outlined,
                  title: "Ongoing",
                ),
                VertDivider(),
                MangaInfoBtn(
                  icon: Icons.format_list_bulleted_sharp,
                  title: "Chapters",
                ),
                VertDivider(),
                Column(
                  children: [
                    IconButton(
                      iconSize: 30,
                      alignment: Alignment.topCenter,
                      onPressed: () {
                        
                         setState(() {
                          
                          iconv = Icon(Icons.favorite_outlined);
                        });
                      },
                      icon: iconv,
                      color: Color.fromARGB(255, 58, 139, 220),
                   
                    ),
                    Text(
                      "Favorite",
                      
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
