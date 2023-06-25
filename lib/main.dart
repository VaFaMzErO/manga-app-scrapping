import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:manga_reader/screens/home/ContentScreen.dart';
import 'package:manga_reader/screens/home/HomeScreen.dart';
import 'package:manga_reader/screens/root.dart';
import 'components/ourTheme.dart';
import 'screens/authenticate/SignInScreen.dart';
import 'screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     // theme: OurTheme().buildTheme(),
      //home: Wrapper(),

      home: Login(),
      title: 'Зурагт ном',
     // home: OurRoot(),
      // home: ContentScreen(),
      // home: DetailScreen(
      //     mangaImg: "https://avt.mkklcdnv6temp.com/18/g/1-1583464407.jpg",
      //     mangaTitle: "A-Bout!",
      //     mangaLink: "https://chap.manganelo.com/manga-we89050",
      //   ),
    );
  }
}
