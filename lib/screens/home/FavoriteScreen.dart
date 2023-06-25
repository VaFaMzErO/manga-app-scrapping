import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/homeScreen/MangaList.dart';
import '../../constants/constants.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavScreenState createState() => _FavScreenState();
}

deleteFromFav() async {
  final FirebaseAuth _authn = FirebaseAuth.instance;
  var currentUser = _authn.currentUser;
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection("user-data");
  return _collectionRef
      .doc(currentUser.email)
      .set({
        //    "favoritedBooks": mangaLink,
      })
      .then((value) => print("user data added"))
      .catchError((error) => print("something is wrong. $error"));
}

class _FavScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Таалагдсан"),
        backgroundColor: Constants.darkgray,
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))]
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user-data")
                .doc(FirebaseAuth.instance.currentUser.email)
                .collection("favoritedBooks")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("error"),
                );
              }
              print(FirebaseFirestore.instance
                  .collection("user-data")
                  .doc(FirebaseAuth.instance.currentUser.email)
                  .collection("favoritedBooks")
                  .snapshots());
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data.docs[index];
                  return ListTile(
                    leading: Text(_documentSnapshot['name']),
                    title: null,
                    trailing: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.remove_circle),
                        ),
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection("user-data")
                              .doc(FirebaseAuth.instance.currentUser.email)
                              .collection("favoritedBooks")
                              .doc(_documentSnapshot.id)
                              .delete();
                        }),
                  );
                },
              );
              //  MangaList(
              //       mangaList: mangaList,
              //       mangaUrlList: mangaUrlList,
              //     )
              //    Center(child: CircularProgressIndicator()),
            }),
      ),
    );
  }
}
