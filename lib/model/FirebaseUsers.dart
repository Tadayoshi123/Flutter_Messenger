import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUsers {
  late String uid;
  late String username;
  late String mail;
  String? avatar;

  FirebaseUsers.vide();

  FirebaseUsers(DocumentSnapshot snapshot){
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    uid = snapshot.id;
    username = map["USERNAME"];
    mail = map["MAIL"];
    avatar = map["AVATAR"];
  }
}