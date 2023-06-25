import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_reader/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';

import 'SignInScreen.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context,
      String fullName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg:'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg:'The account already exists for that email.');
        
      }
      Fluttertoast.showToast(msg:" Амжилттай бүртгэгдлээ");
      Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
    } catch (e) {
      print(e);
    }
    final FirebaseAuth _authn = FirebaseAuth.instance;
    var currentUser = _authn.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("user-data");
    return _collectionRef.doc(currentUser.email).set({
          "name": fullName,
          "password": password,
        })
        .then((value) => print("user data added"))
        .catchError((error) => print("something is wrong. $error")); // try {
    //   String _returnString = await Auth().signUpUser(email, password, fullName);
    //   if (_returnString == "success") {
    //
    //   } else {
    //     Scaffold.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(_returnString),
    //         duration: Duration(seconds: 2),
    //       ),
    //     );
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 8.0),
            child: Text(
              "Бүртгүүлэх",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Нэр",
            ),
          ),
          SizedBox(
            height: 20.0,
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
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: "Дахин нууц үг",
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
                "Бүртгүүлэх",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(_emailController.text, _passwordController.text,
                    context, _fullNameController.text);
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Нууц үг таарахгүй байна"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
