import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  Timestamp accountCreated;
  String fullName;
  String groupId;
  String notifToken;

  UserModel({
    this.uid,
    this.email,
    this.accountCreated,
    this.fullName,
    this.groupId,
    this.notifToken,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.data();
    accountCreated = doc.data();
    fullName = doc.data();
    groupId = doc.data();
    notifToken = doc.data();
  }
}