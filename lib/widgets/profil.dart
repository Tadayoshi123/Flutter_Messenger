import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/functions/FirestoreHelper.dart';
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

  ///
  @override
  Widget build(BuildContext context) {
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

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          //Afficher l'avatar

          InkWell(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (myProfil.avatar == null)
                          ? const NetworkImage(
                              "https://voitures.com/wp-content/uploads/2017/06/Kodiaq_079.jpg.jpg")
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

          //TODO réussir à afficher le pseudonyme
          //Afficher le pseudonyme
          Text(myProfil.username)
        ],
      ),
    );
  }
}
