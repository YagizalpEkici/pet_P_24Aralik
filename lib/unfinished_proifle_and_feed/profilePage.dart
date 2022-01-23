import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/firestore_related/posts.dart';

import 'package:pet_project/unfinished_proifle_and_feed/navigation_drawer_widget.dart';

import 'followerListPage.dart';
import 'followingListPage.dart';


class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);


  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  int currentIndex = 0;
  void editProfile() {
    Navigator.pushNamed(context, '/editProfile');
  }

  void friendshipRequests() {
    Navigator.pushNamed(context, '/friendshipRequests');
  }

  void followerListPage(followers) {
    Navigator.pushNamed(context, '/followerListPage', arguments:followers);
  }

  void followingListPage( List<dynamic> following) {

    //Navigator.of(context).push(MaterialPageRoute(builder:(context)=>followingListPage(following)));

    /*List<dynamic> listToSend = following;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => followingListPage(following: listToSend,),
        ));*/
    //Navigator.pushNamed(context, '/followingListPage', arguments:following);
  }

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

  List<dynamic> updateLike = [];

  String page = "profile";

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

  updateForumData(pid, currEmail, updateLike) async{

    List<dynamic>  currentlikeArray = [];
    var x = await FirebaseFirestore.instance
        .collection('posts')
        .where('pid', isEqualTo: pid)
        .get();
    setState(() {
      currentlikeArray = x.docs[0]['likes'];
      updateLike = currentlikeArray;

    });

    updateLike.add(currEmail);

    FirebaseFirestore.instance
        .collection('posts')
        .doc(pid)
        .update({
      "likes": updateLike,
    })
        .then((value) => print("Forum Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    SnackBar successSnackBar =
    SnackBar(content: Text("Profile has been updated."));
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
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.green,

        title: Text(
          currentUser!.username,
          style: TextStyle(
            color: Colors.black,
            letterSpacing: -1,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: editProfile,
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: friendshipRequests,
          ),
        ],

        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('posts').snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Follower',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),
                                InputChip(
                                  label: Container(
                                    child: Text(
                                      '${followers.length}',
                                      textAlign: TextAlign.center,
                                    ),
                                    width: 80,
                                    height: 20,
                                  ),
                                  onPressed: ()
                                  {
                                    Navigator.pushNamed(
                                        context, '/followerListPage',
                                        arguments: {
                                          'followerList': currentUser!.followers,

                                        });
                                  },
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Text('Breed',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                                Chip(
                                  label:
                                  Container(
                                    child: Text(
                                      '${breed}',
                                      textAlign: TextAlign.center,
                                    ),
                                    width: 90,
                                    height: 20,
                                  ),
                                ),
                              ],

                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                                radius: 56,
                              ),

                            ),

                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text('Following',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                  ],
                                ),
                                InputChip(
                                  label: Container(
                                    child: Text(
                                      '${following.length}',
                                      textAlign: TextAlign.center,
                                    ),
                                    width: 80,
                                    height: 20,
                                  ),
                                  onPressed: ()
                                  {
                                    Navigator.pushNamed(
                                        context, '/followingListPage',
                                        arguments: {
                                          'followingList': currentUser!.following,

                                        });
                                  },
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Text('BirthYear',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Chip(
                                  label:
                                  Container(
                                    child: Text(
                                      '${birthYear}',
                                      textAlign: TextAlign.center,
                                    ),
                                    width: 80,
                                    height: 20,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bio',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                          child: Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),),
                            color: Colors.grey[300],
                            elevation: 8,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${bio}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'POSTS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(thickness: 4,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      if(doc.get('email') == email) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/otherUserProfile', arguments: {'email':doc.get('email'), 'email2':email, 'username2':username});
                                    print('button clicked');
                                  },
                                ),
                                title: Text(doc['username']),
                                subtitle: Text(
                                  ('$date'),
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  doc['content'],
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ),

                              Image.asset('assets/image1.jpg'),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.thumb_up),
                                    onPressed: () {
                                      if(!doc.get('likes').contains(currentUser!.email)){
                                        updateForumData(doc.get('pid'), currentUser!.email, updateLike);
                                      }
                                      // Perform some action

                                    },
                                    label: Text('${doc.get('likes').length}'),
                                  ),


                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.comment),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/CommentPage', arguments: {'pid': doc.get('pid'), 'page':page});
                                      // Perform some action
                                    },
                                    label: const Text(''),
                                  ),
                                  ElevatedButton.icon(

                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),


                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.delete_forever,
                                    ),

                                    onPressed: () async {


                                      List<dynamic> updatedPosts=[];
                                      FirebaseAuth _auth;
                                      User? _user;
                                      _auth = FirebaseAuth.instance;
                                      _user = _auth.currentUser;
                                      var dbUserGetter = await FirebaseFirestore.instance.collection('user').where('email', isEqualTo: currentUser!.email).get();
                                      updatedPosts = dbUserGetter.docs[0]['posts'];
                                      updatedPosts.remove(doc.get('pid'));
                                      FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(_user?.email)
                                          .update({
                                        "posts": updatedPosts,
                                      });

                                      FirebaseFirestore.instance.collection('posts').doc(doc.get('pid')).delete();


                                      // Perform some action
                                    },
                                    label: const Text(''),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

