// import 'package:manga_reader/models/groupModel.dart';
import 'package:manga_reader/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBStream {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<UserModel> getCurrentUser(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((docSnapshot) => UserModel.fromDocumentSnapshot(doc: docSnapshot));
  }

  // Stream<GroupModel> getCurrentGroup(String groupId) {
  //   return _firestore
  //       .collection('groups')
  //       .document(groupId)
  //       .snapshots()
  //       .map((docSnapshot) => GroupModel.fromDocumentSnapshot(doc: docSnapshot));
  // }
}