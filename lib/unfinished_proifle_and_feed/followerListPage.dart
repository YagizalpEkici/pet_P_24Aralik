import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:pet_project/firestore_related/posts.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/unfinished_proifle_and_feed/profilePage.dart';


class PasswordRoute extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordRoute> {

  String password="";
  String name="";
  String surname="";
  String petName="";
  String sex="";
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String bio = "",
      username = "",
      breed = "",
      photoUrl = "",
      birthYear = "";
  List<dynamic> postsUser = [];
  bool profType=true;
  List<dynamic> posts = [];
  String email ="";

  DateTime? date;
  String postPhotoURL = "";
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  String content = "";
  String pid = "";

  user? currentUser;
  Post? currentPost;

  void _loadUserInfo() async {
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var x = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: _user?.email)
        .get();

    setState(() {
      username = x.docs[0]['username'];
      password=x.docs[0]['password'];
      name=x.docs[0]['name'];
      surname=x.docs[0]['surname'];
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      sex=x.docs[0]['sex'];
      petName=x.docs[0]['petName'];
      photoUrl = x.docs[0]['photoUrl'];
      bio = x.docs[0]['bio'];
      breed = x.docs[0]['breed'];
      birthYear = x.docs[0]['birthYear'];
      email=x.docs[0]['email'];
      posts=x.docs[0]['posts'];
      profType=x.docs[0]['profType'];

    });
  }
  bool feedLoading = true;
  int postsSize = 0;

  void _loadUserProf() async {

    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    var x = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: _user?.email)
        .get();


    var profPosts = await FirebaseFirestore.instance
        .collection('posts')
        .where('email', isEqualTo: _user?.email)
        .get();


    postsSize = profPosts.size;
    username = profPosts.docs[0]['username'];
    pid = profPosts.docs[0]['pid'];
    date= DateTime.fromMillisecondsSinceEpoch(profPosts.docs[0]['date'].seconds * 1000);
    photoUrl= profPosts.docs[0]['userPhotoUrl'];
    content= profPosts.docs[0]['content'];
    email= profPosts.docs[0]['email'];
    comments= profPosts.docs[0]['comments'];
    likes= profPosts.docs[0]['likes'];
    postPhotoURL= profPosts.docs[0]['postPhotoURL'];


    //posts..sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      print("its in");
      feedLoading = false;
    });
  }

  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadUserProf();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print('sarp');

    currentUser = user(
      username: username,
      name: name,
      surname: surname,
      followers: followers,
      following: following,
      password: password,
      posts: posts,
      bio: bio,
      photoUrl: 'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png',
      profType: profType,
      email:email,
      petName: petName,
      birthYear: birthYear,
      sex: sex,
      breed: breed,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green,

        title: Text(
          'FOLLOWERS',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                if(args['followerList'].contains(doc.get(('email')))) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 30,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                                color: Colors.white,
                                onPressed: () {
                                  if(currentUser!.email == doc.get('email')){
                                    Navigator.push(context, new MaterialPageRoute(
                                        builder: (context) => new profilePage())
                                    );
                                  }
                                  else {
                                    Navigator.pushNamed(
                                        context, '/otherUserProfile',
                                        arguments: {
                                          'email': doc.get('email'),
                                          'email2': currentUser!.email,
                                          'username2': username
                                        });
                                  }
                                  print('button clicked');

                                },
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              doc.get('username'),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  );
                }
                else{
                  return Card();
                }
              }).toList(),
            );

        },
      ),
    );
  }
}


