import 'package:flutter/material.dart';
import 'main.dart';
import 'package:flutter/cupertino.dart';

class discussion extends StatefulWidget {
  discussion({Key? key}) : super(key: key);

  @override
  State<discussion> createState() => discussionState();
}

class discussionState extends State<discussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.transparent,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage("https://img.myloview.fr/stickers/default-avatar-profile-image-vector-social-media-user-icon-400-228654854.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Tadayoshi",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                      SizedBox(height: 6,),
                      Text("En Ligne",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                    ],
                  ),
                ),
              ],
            ),
          )),
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
        child: bodyPage(),
      ),
    );
  }

  Widget bodyPage() {
    return Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.grey.shade800,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ecrire quelque chose...",
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.send,color: Colors.white),
                    elevation: 0,
                  ),
                ],
                
              ),
            ),
          ),
        ],
      );
  }
}
