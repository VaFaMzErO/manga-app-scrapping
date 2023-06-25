import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manga_reader/components/homeScreen/MangaList.dart';
import 'package:manga_reader/constants/constants.dart';
import 'package:manga_reader/widgets/BotNavItem.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget { 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavIndex = 0;
  bool mangaLoaded = false;
  PageController  pageController;
  List<Map<String, dynamic>> mangaList;
  List<Map<String, dynamic>> mangaUrlList;

  // void navBarTap(int index) {
  //   setState(() {
  //     selectedNavIndex = index;
  //   });
  // }

  void fetchManga() async {
    final webscraper = WebScraper(Constants.baseUrl);

    if (await webscraper.loadWebPage('/popular-manga')) {
      mangaList = webscraper.getElement(
        'div.content > div.content-inner.sm > div.row.manga-list-style > div.col-md-4 > a > img',
        ['src', 'alt'],
      );

      mangaUrlList = webscraper.getElement(
        'div.content > div.content-inner.sm > div.row.manga-list-style > div.col-md-4 > a',
        ['href'],
      );
      print(mangaList);
      setState(() {
        mangaLoaded = true;
      });
    }

  }

  @override
  void initState() {
    super.initState();
    
    fetchManga();
  }
onTap(int pageIndex) {
  pageController = PageController();
    pageController.jumpToPage(
      pageIndex,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Зурагт ном"),
          backgroundColor: Constants.darkgray,
          // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))]
          ),
      body: mangaLoaded
          ? MangaList(
              mangaList: mangaList,
              mangaUrlList: mangaUrlList,
            )
          : Center(child: CircularProgressIndicator()),
      // bottomNavigationBar: CupertinoTabBar(
      //     currentIndex: 0,
      //     onTap: onTap,
      //     activeColor: Theme.of(context).primaryColor,
      //     items: [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.whatshot),
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite_outline), 
      //       label: "Favourite"),
          
            
      //       BottomNavigationBarItem(
      //          icon: Icon(Icons.person),
      //       label: "Person",
      //       ),
      //     ]),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Constants.darkgray,
      //   selectedItemColor: Constants.lightblue,
      //   unselectedItemColor: Colors.white,
      //   currentIndex: selectedNavIndex,
      //   onTap: navBarTap,
      //   items: [
      //     botNavItem(Icons.explore_outlined, "EXPLORE"),
      //     // botNavItem(Icons.favorite, "FAVORITE"),
      //     // botNavItem(Icons.watch_later, "RECENT"),
      //     botNavItem(Icons.more_horiz, "MORE"),
      //   ],
      // ),
    );
  }
}
