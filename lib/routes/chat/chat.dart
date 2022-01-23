import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/routes/chat/chatusers.dart';
import 'package:pet_project/routes/chat/chatuserslist.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/routes/chat/ChatDataBase.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}
class _ChatState extends State<Chat> {
  /*
  late QuerySnapshot searchSnapshot;
  ChatDataBase chatDataBase = new ChatDataBase();
  TextEditingController searchtextEditingController = new TextEditingController();
  final QuerySnapshot result = FirebaseFirestore.instance.collection('user').get() as QuerySnapshot<Object?>;
  */

/*
  initiateSearch(){
    chatDataBase
        .getUserByUsername(searchtextEditingController.text)
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
      });
  }
  */
  /*
  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchSnapshot.docs.length,
        itemBuilder: (context, index){
          return ChatUsersList(
              userEmail: searchSnapshot.docs[index].data(),
              userName: searchSnapshot.docs[index].data(),
              image: "",
          );
        }) : Container();
  }
*/
  List<ChatUsers> chatUsers = [
    ChatUsers(text: "Sarp Bora Polat", secondaryText: "Wanna play F1 video game at 10 PM!?",image: "image"),
    ChatUsers(text: "Yağızalp Ekici", secondaryText: "Sick!! I've just taken the best picture ever!!", image: "image"),
    ChatUsers(text: "Bengisu Özdemir", secondaryText: "I'm tired of all this F1 stuff! Pfff... ", image: "image"),
    ChatUsers(text: "Esra Nur Özüm", secondaryText: "My Sanity < CS310, That's all I wanna say.", image: "image"),
    ChatUsers(text: "Mustafa Ata Onbaş", secondaryText: "#grateful", image: "image"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
        body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //searchList(),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget> [
                    Text('Chats', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  //controller: searchtextEditingController,
                  /*onTap: (){
                    initiateSearch();
                  },*/
                  decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20,),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
            ),
          //),
            /*StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('user').snapshots(),
                builder: (context, index) =>
                  ListView.builder(
                      itemCount: result.docs.length,
                      itemBuilder: (context, index){
                        return ChatUsersList(
                            userEmail: result.docs[index].data(),
                            userName: result.docs[index].data(),
                            image: "image"
                        );
                      }
                  ),
            ),*/
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ChatUsersList(
                    text: chatUsers[index].text,
                    secondaryText: chatUsers[index].secondaryText,
                    image: chatUsers[index].image,
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}