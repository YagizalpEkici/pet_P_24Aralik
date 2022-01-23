import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/comments.dart';

import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/unfinished_proifle_and_feed/HomeScreen.dart';
import 'package:pet_project/unfinished_proifle_and_feed/profilePage.dart';


import 'package:uuid/uuid.dart';

var uuid = Uuid();

class generateComment extends StatefulWidget {
  const generateComment({Key? key}) : super(key: key);

  @override
  _generateCommentState createState() => _generateCommentState();
}

class _generateCommentState extends State<generateComment> {
  final _formKey = GlobalKey<FormState>();

  String comment = "";
  String Commentemail = "";
  String cid = "";
  String pid = "";
  String Commentusername = "";

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

  DateTime? date;
  String postPhotoURL = "";
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  String content = "";

  user? currentUser;

  void pageDirection() {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args['page']);
    if(args['page'] == 'home') {
      Navigator.pushNamed(context, '/homePage');
    }
    else if(args['page'] == 'profile'){
      Navigator.push(context, new MaterialPageRoute(
          builder: (context) => new profilePage())
      );

    }
    else if(args['page'] == 'otherProfile') {
      Navigator.pushNamed(context, '/otherUserProfile');
    }
  }

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


  Future<void> addComment(Comments CUser) async {
    final CollectionReference comments = FirebaseFirestore.instance.collection('comments');
    try {
      await comments.doc(CUser.cid).set(CUser.toJson());
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      return null;
    }
  }

  List<dynamic> updatecomment = [];

  updateCommentData(pid,cid) async{
    print(cid);
    print(pid);
    print('ssdsdsdsdsds');

    List<dynamic>  currentlikeArray = [];
    var x = await FirebaseFirestore.instance
        .collection('posts')
        .where('pid', isEqualTo: pid)
        .get();
    setState(() {
      currentlikeArray = x.docs[0]['comments'];
      updatecomment = currentlikeArray;

    });

    updatecomment.add(cid);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(pid)
        .update({
      "comments": updatecomment,
    })
        .then((value) => print("Forum Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    SnackBar successSnackBar =
    SnackBar(content: Text("Profile has been updated."));
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
          automaticallyImplyLeading: false,
          title: Text(
            'MAKE A COMMENT',
          ),
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
        ),
        body: SafeArea(
            child : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "your comment",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if(value==null){
                                    return 'Comment field cannot be empty!';
                                  }
                                  else{
                                    String trimmedValue = value.trim();
                                    if(trimmedValue.isEmpty){
                                      return 'Comment field cannot be empty';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  if(value != null){
                                    comment = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 20,),

                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 80,),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                            if(states.contains(MaterialState.pressed))
                                              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                            return Colors.blueGrey;
                                          },
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          var result = await FirebaseFirestore
                                              .instance
                                              .collection('comments')
                                              .get();
                                          print('dışardayız');
                                          if (result.size >= 0) {
                                            print('içerdeyiz');
                                            Comments CUser = Comments(
                                              comment: comment,
                                              Commentemail: currentUser!.email,
                                              cid: id,
                                              pid: args['pid'],
                                              Commentusername: currentUser!.username,
                                            );
                                            addComment(CUser);
                                            updateCommentData(args['pid'], CUser.cid);
                                            pageDirection();
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 80,),
                                  ],
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            )
        )
    );
  }
}
