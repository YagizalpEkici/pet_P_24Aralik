import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/posts.dart';
import 'package:pet_project/firestore_related/users.dart';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

class reSharePage extends StatefulWidget {
  const reSharePage({Key? key}) : super(key: key);

  @override
  _reSharePageState createState() => _reSharePageState();
}

class _reSharePageState extends State<reSharePage> {

  String id = uuid.v4();

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

  user? currentUser;

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

  addPostToUser() {
    setState(() {

    });
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;

    FirebaseFirestore.instance
        .collection('user')
        .doc(_user?.email)
        .update({
      "posts": posts,
    })

        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    SnackBar successSnackBar =
    SnackBar(content: Text("Profile has been updated."));
  }

  Future<void> addPost(Post cPost) async {
    final CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    //var post_ref = posts.doc();
    try {
      //
      await posts.doc(cPost.pid).set(cPost.toJson());
      print("null olmadı");
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print("null oldu");
      return null;
    }
  }

  void pageDirection() {
    Navigator.pushNamed(this.context, '/homePage');
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

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
        title: Text(
            'ReShare a Post',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    leading: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Image.network(
                          'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                      color: Colors.white,
                      onPressed: () {
                        /////////
                      },
                    ),
                    title: Text(
                      currentUser!.username,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      ('26.12.2021'),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      args['content'],
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Image.asset('assets/image1.jpg'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: Text('Share'),
              onPressed: () async{
                  var result = await FirebaseFirestore
                      .instance
                      .collection('posts')
                      .where(
                      'email', isEqualTo: currentUser!.email)
                      .get();
                  print(result.size);
                  if (result.size >= 0) {
                    FirebaseAuth _auth;
                    _auth = FirebaseAuth.instance;
                    User? _user = _auth.currentUser;
                    print("result 0");
                    Post cPost = Post(
                      username: currentUser!.username,
                      content: args['content'],
                      pid: id,
                      userPhotoUrl: 'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png',
                      comments: [],
                      likes: [],
                      email: currentUser!.email,
                      postPhotoURL: 'assets/image1.jpg',
                      date: DateTime.now(),
                    );
                    addPost(cPost);
                    posts.add(id);
                    addPostToUser();
                    //updateUserData();

                    pageDirection();
                  }
              },
            ),
          ],
        ),
      ),
    );
  }
}
