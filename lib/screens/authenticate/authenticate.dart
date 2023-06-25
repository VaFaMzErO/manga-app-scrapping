import 'package:flutter/material.dart';
import 'package:manga_reader/screens/authenticate/SignInScreen.dart';

class Authenticate extends StatefulWidget {

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Login(),
    );
  }
}
