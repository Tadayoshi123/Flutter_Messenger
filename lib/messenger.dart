import 'package:flutter/material.dart';
import 'package:flutter_messenger/contacts.dart';
import 'functions/FirestoreHelper.dart';
import 'model/FirebaseUsers.dart';
import 'widgets/profil.dart';

class messenger extends StatefulWidget {
  messenger({Key? key}) : super(key: key);

  @override
  State<messenger> createState() {
    return messengerState();
  }
}

class messengerState extends State<messenger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussions"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage() {
    return Column(children: [
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return contact();
          }));
        },
        child: const Text(
          "Liste contacts",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return profil();
          }));
        },
        child: const Text(
          "Mon Profil",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    ]);
  }
}
