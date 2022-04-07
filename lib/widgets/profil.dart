import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/functions/FirestoreHelper.dart';
import 'package:flutter_messenger/main.dart';
import 'package:flutter_messenger/model/FirebaseUsers.dart';

class profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return profilState();
  }
}

class profilState extends State<profil> {
  FirebaseUsers myProfil = FirebaseUsers.vide();
  Uint8List? byteFile;
  String? nameFile;
  String? urlFile;

  //Function

  //Récupérer l'image sur notre téléphone
  getImage() async {
    FilePickerResult? resultat = await FilePicker.platform
        .pickFiles(withData: true, type: FileType.image);
    if (resultat != null) {
      nameFile = resultat.files.first.name;
      byteFile = resultat.files.first.bytes;
      popImage();
    }
  }

  //Afficher l'image choisie
  popImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Voulez-vous enregistrer cette image ?"),
            content: Image.memory(byteFile!),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //Annuler
                  Navigator.pop(context);
                },
                child: const Text("Annuler"),
              ),
              ElevatedButton(
                  onPressed: () {
                    //enregsiter notre image dans la base de donnée
                    FirestoreHelper()
                        .stockImage(nameFile!, byteFile!)
                        .then((String urlImage) {
                      setState(() {
                        urlFile = urlImage;
                        Map<String, dynamic> map = {
                          "AVATAR": urlFile,
                        };
                        FirestoreHelper().updateUser(myProfil.uid, map);
                      });
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("Enregistrement"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
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
    FirestoreHelper().getID().then((String identifiant) {
      setState(() {
        String monId = identifiant;
        FirestoreHelper().getUser(monId).then((FirebaseUsers monUser) {
          setState(() {
            myProfil = monUser;
          });
        });
      });
    });

    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          //Afficher l'avatar

          InkWell(
            child: Container(
              height: 128,
              width: 128,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (myProfil.avatar == null)
                          ? const NetworkImage(
                              "https://img.myloview.fr/stickers/default-avatar-profile-image-vector-social-media-user-icon-400-228654854.jpg")
                          : NetworkImage(myProfil.avatar!))),
            ),
            onTap: () {
              //Récuperer image
              print("Je vais récupérer l'image");
              getImage();
            },
          ),

          const SizedBox(
            height: 20,
          ),

          //Username
          TextField(
              onChanged: (newUserName) {
                setState(() {
                  myProfil.username = newUserName;
                });
                Map<String, dynamic> map = {
                  "USERNAME": newUserName,
                };
                FirestoreHelper().updateUser(myProfil.uid, map);
              },
              decoration: InputDecoration(
                hintText: "Modifier votre pseudonyme",
                labelText: "${myProfil.username}",
              )),
        ],
      ),
    );
  }
}
