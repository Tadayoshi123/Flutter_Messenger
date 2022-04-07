import 'package:flutter/material.dart';
import 'package:flutter_messenger/discussion.dart';
import 'package:flutter_messenger/messenger.dart';
import 'package:flutter_messenger/main.dart';
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
  final Stream<QuerySnapshot> contactStream = FirebaseFirestore.instance.collection('FirebaseUsers').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyHomePage(title: '');
                }));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: bodyPage(),
      ),
    );
  }
  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
      stream: contactStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data['AVATAR']),
              ),
              title: Text(data['USERNAME']),
              iconColor: Colors.blue,
              trailing: const Icon(Icons.message),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                  return discussion();
                }));
              },
            );
          }).toList(),
        );
      },
    );
  }
}

//TODO afficher la liste des contacts