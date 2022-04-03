import 'package:flutter/material.dart';
import 'package:flutter_messenger/functions/FirestoreHelper.dart';
import 'main.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return registerState();
  }
}

class registerState extends State<register> {
  late String mail;
  late String password;
  late String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        //------------Username-----------------
        TextField(
          onChanged: (value) {
            setState(() {
              username = value;
            });
          },
          decoration: const InputDecoration(
            filled: true,
            hintText: "Entrez votre pseudonyme",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        //------------Mail-----------------
        TextField(
          onChanged: (value) {
            setState(() {
              mail = value;
            });
          },
          decoration: const InputDecoration(
            filled: true,
            hintText: "Entrez votre mail",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),

        //------------Password-----------------
        TextField(
          obscureText: true,
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          decoration: const InputDecoration(
            filled: true,
            hintText: "Entrez votre mot de passe",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),

        //------------Register-----------------
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              print("Inscription réussi.");
              FirestoreHelper().registerFirebaseUser(username, mail, password);
            },
            child: const Text("Inscription")),

        //------------Login link-----------------
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const MyHomePage(
                title: '',
              );
            }));
          },
          child: const Text(
            "Connexion",
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
