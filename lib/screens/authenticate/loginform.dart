//import 'package:manga_reader/screens/root.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_reader/screens/authenticate/SignUp.dart';
import 'package:manga_reader/screens/home/HomeScreen.dart';
import 'package:manga_reader/services/auth.dart';
import 'package:manga_reader/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';

import '../../services/auth_test.dart';
import '../../widgets/bottomNavController.dart';
import '../root.dart';

enum LoginType {
  email,
  google,
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color favIconColor = Color.fromARGB(255, 157, 149, 149);

  // AuthService _auth = AuthService();
  void _login_in({String email, String pass, BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      var authCredential = userCredential.user;
      print(authCredential.uid);
      if (authCredential.uid.isNotEmpty) {
        Fluttertoast.showToast(msg:"Амжилттай нэвтэрлээ");
        Navigator.push(
            context, CupertinoPageRoute(builder: (_) => BottomNavController()));
      } else {

        Fluttertoast.showToast(msg:"Something is wrong");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg:'Энэ хаяг буруу байна.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg:'Буруу нууц үг.');
      }
    } catch (e) {
      print(e);
    }
  }

  //login user with email
  // void _loginUser({
  //   @required LoginType type,
  //   String email,
  //   String password,
  //   BuildContext context,
  // }) async {
  //   try {
  //     String _returnString;
  //         _returnString = await Auth().loginUserWithEmail(email, password);
  //     if (_returnString == "error") {
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //              builder: (context) => HomeScreen(),
  //             ),
  //         (route) => false,
  //       );
  //     } else {
  //       Scaffold.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(_returnString),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Widget _googleButton() {
  //   return OutlineButton(
  //     splashColor: Colors.grey,
  //     onPressed: () {
  //       _loginUser(type: LoginType.google, context: context);
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //     highlightElevation: 0,
  //     borderSide: BorderSide(color: Colors.grey),
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
  //       child: Row(
  //         mainAxisSize: MainAxisSize.min,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 10),
  //             child: Text(
  //               'Sign in with Google',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Нэвтрэх",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: "И-мэйл",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Нууц үг",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Padding(
              
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Text(
                "Нэвтрэх",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            color: favIconColor,
            onPressed: () {
              setState(() {
                 
                 favIconColor = Color.fromARGB(255, 34, 202, 82) ;// the one selected from the drop down menu
               });

              _login_in(
                  email: _emailController.text,
                  pass: _passwordController.text,
                  context: context);
              
            },
            //  async {
            //   dynamic result = await _auth.signInAnon();
            //   if (result == null) {
            //     print('error in signing in');
            //   } else {
            //     print('signed in');
            //     print(result);
            //   }
            // }

            // FirebaseAuth.instance
            //     .signInWithEmailAndPassword(
            //         email: _emailController.text,
            //         password: _passwordController.text)
            //     .then((value) {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => HomeScreen()));
            // });
          ),
          FlatButton(
            child: Text("Шинээр бүртгүүлэх бол энд дарна уу"),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
          ),
          // _googleButton(),
        ],
      ),
    );
  }
}
