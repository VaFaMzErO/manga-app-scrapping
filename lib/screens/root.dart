// // TODO Implement this library.import 'dart:io';

// import 'dart:io';

// import 'package:manga_reader/models/authModel.dart';
// // import 'package:manga_reader/models/groupModel.dart';
// import 'package:manga_reader/models/userModel.dart';
// // import 'package:manga_reader/screens/inGroup/inGroup.dart';
// import 'package:manga_reader/screens/authenticate/SignInScreen.dart';
// import 'package:manga_reader/screens/home/HomeScreen.dart';
// // import 'package:manga_reader/screens/noGroup/noGroup.dart';
// import 'package:manga_reader/screens/splashScreen.dart';
// import 'package:manga_reader/services/dbStream.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// enum AuthStatus { unknown, notLoggedIn, loggedIn }

// class OurRoot extends StatefulWidget {
//   @override
//   _OurRootState createState() => _OurRootState();
// }

// class _OurRootState extends State<OurRoot> {
//   AuthStatus _authStatus = AuthStatus.unknown;
//   String currentUid;
//   // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

//   @override
//   void initState() {
//     super.initState();
// //  if (Platform.isIOS) {
// //       _firebaseMessaging
// //           .requestPermission();
// //       _firebaseMessaging.onTokenRefresh.listen((event) {
// //         print("IOS Registered");
// //       });
// //     }

// //     _firebaseMessaging.onmessage(
// //       onMessage: (Map<String, dynamic> message) async {
// //         print("onMessage: $message");
// //       },
// //       onLaunch: (Map<String, dynamic> message) async {
// //         print("onLaunch: $message");
// //       },
// //       onResume: (Map<String, dynamic> message) async {
// //         print("onResume: $message");
// //       },
// //     );
//   }

//   @override
//   void didChangeDependencies() async {
//     super.didChangeDependencies();

//     //get the state, check current User, set AuthStatus based on state
//     AuthModel _authStream = Provider.of<AuthModel>(context);
//     if (_authStream != null) {
//       setState(() {
//         _authStatus = AuthStatus.loggedIn;
//         currentUid = _authStream.uid;
//       });
//     } else {
//       setState(() {
//         _authStatus = AuthStatus.notLoggedIn;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget retVal;

//     switch (_authStatus) {
//       case AuthStatus.unknown:
//         retVal = SplashScreen();
//         break;
//       case AuthStatus.notLoggedIn:
//         retVal = Login();
//         break;
//       case AuthStatus.loggedIn:
//         retVal = StreamProvider<UserModel>.value(
//           value: DBStream().getCurrentUser(currentUid),
//           child: LoggedIn(),
//         );
//         break;
//       default:
//     }
//     return retVal;
//   }
// }

// class LoggedIn extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     UserModel _userStream = Provider.of<UserModel>(context);
//     Widget retVal;
//     if (_userStream != null) {
//       if (_userStream.groupId != null) {
    
//       } else {
      
//       }
//     } else {
//       retVal = SplashScreen();
//     }

//     return HomeScreen();
//   }
// }