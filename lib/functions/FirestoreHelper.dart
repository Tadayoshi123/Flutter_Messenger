import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_messenger/model/FirebaseUsers.dart';

class FirestoreHelper {
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("FirebaseUsers");
  final fireStorage = FirebaseStorage.instance;

  //---------------------------Methods--------------------------------

  Future registerFirebaseUser(
      String username, String mail, String password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: mail, password: password);
    User? user = result.user;
    String uid = user!.uid;
    Map<String, dynamic> values = {
      "USERNAME": username,
      "MAIL": mail,
    };
    addUser(uid, values);
  }

  Future<String> loginFirebaseUser(String mail, String password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: mail, password: password);
    return result.user!.uid;
  }

  addUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).set(map);
  }

  updateUser(String uid, Map<String, dynamic> map) {
    fire_user.doc(uid).update(map);
  }

  Future<String> getID() async {
    String uid = auth.currentUser!.uid;
    return uid;
  }

  Future<FirebaseUsers> getUser(String uid) async {
    DocumentSnapshot snapshot = await fire_user.doc(uid).get();
    return FirebaseUsers(snapshot);
  }

  Future<String> stockImage(String name, Uint8List data) async {
    String? urlChemin;
    TaskSnapshot snapshotTask =
        await fireStorage.ref("image/$name").putData(data);
    urlChemin = await snapshotTask.ref.getDownloadURL();
    return urlChemin!;
  }
}
