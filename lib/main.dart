import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'functions/FirestoreHelper.dart';
import 'register.dart';
import 'messenger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Messenger',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Connexion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String mail;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Connexion'),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: bodyPage(),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  //show popUp when connection failed
  popUp() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: const Text(
                  "Connexion échouée, réessayez sans faire de faute ou inscrivez-vous."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          } else {
            return AlertDialog(
              title: const Text(
                  "Connexion échouée, réessayez sans faire de faute ou inscrivez-vous."),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK"))
              ],
            );
          }
        });
  }

  Widget bodyPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(
          height: 10,
        ),

        //-----------------------Mail-----------------------------
        TextField(
          onChanged: (value) {
            setState(() {
              mail = value;
            });
          },
          decoration: const InputDecoration(
            filled: true,
            hintText: "Entrez votre adresse mail",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //----------------------Password---------------------------
        TextField(
          onChanged: (value) {
            setState(() {
              password = value;
            });
          },
          obscureText: true,
          decoration: const InputDecoration(
            filled: true,
            hintText: "Entrez votre mot de passe",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 10,
        ),

        //------------------------Login------------------------------
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              FirestoreHelper().loginFirebaseUser(mail, password).then((value) {
                print("Connexion réussie");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return messenger();
                }));
              }).catchError((onError) {
                print("Connexion échouée");
                popUp();
              });
            },
            child: const Text("Connexion")),
        const SizedBox(
          height: 10,
        ),

        //-------------Register link--------------------
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const register();
            }));
          },
          child: const Text(
            "Inscription",
            style: TextStyle(color: Colors.teal),
          ),
        ),
      ],
    );
  }
}
