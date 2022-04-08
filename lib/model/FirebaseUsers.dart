import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsers {
  late String uid;
  String? username;
  late String mail;
  String? avatar;
  List contacts = [];

  FirebaseUsers.vide();

  FirebaseUsers(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    uid = snapshot.id;
    username = map["USERNAME"];
    mail = map["MAIL"];
    avatar = map["AVATAR"];
    contacts = map["CONTACTS"];
  }
}
