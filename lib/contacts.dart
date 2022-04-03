import 'package:flutter/material.dart';
import 'model/FirebaseUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class contact extends StatefulWidget {
  contact({Key? key}) : super(key: key);

  @override
  State<contact> createState() {
    return contactState();
  }
}

class contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//TODO afficher la liste des contacts