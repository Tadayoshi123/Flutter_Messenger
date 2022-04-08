import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/contacts.dart';
import 'package:flutter_messenger/main.dart';
import 'discussion.dart';
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
  FirebaseUsers currentUser = FirebaseUsers.vide();
  final Stream<QuerySnapshot> contactStream =
      FirebaseFirestore.instance.collection('FirebaseUsers').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussions"),
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return messenger();
                    }));
                  },
                  icon: const Icon(Icons.messenger)),
              label: "Discussions"),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return profil();
                    }));
                  },
                  icon: const Icon(Icons.person)),
              label: "Mon Profil"),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return contact();
                    }));
                  },
                  icon: const Icon(Icons.people)),
              label: "Mes contacts")
        ],
        currentIndex: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage() {
    FirestoreHelper().getID().then((String userID) {
      setState(() {
        String myID = userID;
        FirestoreHelper().getUser(myID).then((FirebaseUsers myUser) {
          setState(() {
            currentUser = myUser;
          });
        });
      });
    });
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
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data['AVATAR']),
              ),
              title: Text(data['USERNAME']),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return discussion();
                    }));
                  },
                  icon: const Icon(Icons.message)),
            );
          }).toList(),
        );
      },
    );
  }
}
