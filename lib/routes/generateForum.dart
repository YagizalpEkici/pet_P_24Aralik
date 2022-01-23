import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/firestore_related/forum.dart';

import 'package:uuid/uuid.dart';

var uuid = Uuid();

class generateForum extends StatefulWidget {
  const generateForum({Key? key}) : super(key: key);

  @override
  _generateForumState createState() => _generateForumState();
}

class _generateForumState extends State<generateForum> {
  final _formKey = GlobalKey<FormState>();
  String header = "";
  String description = "";
  String fid = "";
  int like = 0;
  String usermail = "";

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
  String pid = "";

  user? currentUser;

  void pageDirection() {
    Navigator.pop(context, false);
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


  Future<void> addForum(forum fUser) async {
    final CollectionReference forums = FirebaseFirestore.instance.collection('forums');
    try {
      await forums.doc(fUser.fid).set(fUser.toJson());
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
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
          'CREATE A STATE',
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
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
                                  hintText: "Header",
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
                                    return 'Header field cannot be empty!';
                                  }
                                  else{
                                    String trimmedValue = value.trim();
                                    if(trimmedValue.isEmpty){
                                      return 'Header field cannot be empty';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  if(value != null){
                                    header = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "description",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                onSaved: (value){
                                  if(value != null){
                                    description = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
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
                                              .collection('forums')
                                              .get();
                                          print('dışardayız');
                                          if (result.size >= 0) {
                                            print('içerdeyiz');
                                            forum fUser = forum(
                                              header: header,
                                              description: description,
                                              like: like,
                                              fid: id,
                                              username: username,
                                              photo: 'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png',
                                              usermail: currentUser!.email,
                                            );
                                            addForum(fUser);
                                            pageDirection();
                                          }
                                        }
                                      },
                                      child: Text(
                                        'Enter',
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

