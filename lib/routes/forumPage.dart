import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';
import 'package:pet_project/unfinished_proifle_and_feed/profilePage.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post_tile.dart';
import 'package:pet_project/routes/generateForum.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';



class forumPage extends StatefulWidget {
  const forumPage({Key? key}) : super(key: key);

  @override
  State<forumPage> createState() => _forumPageState();
}

class _forumPageState extends State<forumPage> {
  final _formKey = GlobalKey<FormState>();

  String password = "";
  String name = "";
  String surname = "";
  String petName = "";
  String sex = "";
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String bio = "",
      usernameCurr = "",
      breed = "",
      photoUrl = "",
      birthYear = "";
  List<dynamic> postsUser = [];
  bool profType = true;
  List<dynamic> posts = [];
  String email = "";

  DateTime? date;
  String postPhotoURL = "";
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  String content = "";
  String pid = "";

  user? currentUser;
  Post? currentPost;

  List<dynamic> updateLike = [];


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
      usernameCurr = x.docs[0]['username'];
      password = x.docs[0]['password'];
      name = x.docs[0]['name'];
      surname = x.docs[0]['surname'];
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      sex = x.docs[0]['sex'];
      petName = x.docs[0]['petName'];
      photoUrl = x.docs[0]['photoUrl'];
      bio = x.docs[0]['bio'];
      breed = x.docs[0]['breed'];
      birthYear = x.docs[0]['birthYear'];
      email = x.docs[0]['email'];
      posts = x.docs[0]['posts'];
      profType = x.docs[0]['profType'];
    });
  }




  void buttonPressed() {
    Navigator.pushNamed(context, '/generateForum');
  }
  String header = "";
  String description = "";
  String fid = "";
  int like = 0;

  String username = "";
  String photo="";

  void _loadForumInfo() async {
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var x = await FirebaseFirestore.instance
        .collection('forums')
        .get();

    setState(() {
      username = x.docs[0]['username'];
      header=x.docs[0]['header'];
      description=x.docs[0]['description'];
      like=x.docs[0]['like'];
      photo = x.docs[0]['photo'];
      fid = x.docs[0]['fid'];
    });
  }
  final db = FirebaseFirestore.instance;

  updateForumData(fid) async{
    int currentlike = 0;
    var x = await FirebaseFirestore.instance
        .collection('forums')
        .where('fid', isEqualTo: fid)
        .get();
    setState(() {
      currentlike = x.docs[0]['like'];
    });
    print(currentlike);

    FirebaseFirestore.instance
        .collection('forums')
        .doc(fid)
        .update({
      "like": currentlike + 1,
    })
        .then((value) => print("Forum Updated"))
        .catchError((error) => print("Failed to update user: $error"));

    SnackBar successSnackBar =
    SnackBar(content: Text("Profile has been updated."));
  }

  @override
  void initState() {
    super.initState();
    _loadForumInfo();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(
          'FORUMs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('forums').snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 610,
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shadowColor: Colors.amber,
                        elevation: 8,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: Image.network(
                                        'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                                    color: Colors.white,
                                    onPressed: () {
                                      if (currentUser!.email == doc.get('usermail')) {
                                        Navigator.push(context, new MaterialPageRoute(
                                            builder: (context) => new profilePage())
                                        );
                                      }
                                      else{
                                        Navigator.pushNamed(
                                            context, '/otherUserProfile',
                                            arguments: {
                                              'email': doc.get('usermail'),
                                              'email2': currentUser!.email,
                                              'username2': currentUser!.username,
                                            });
                                      }
                                      /*
                                      else if(doc.get('followers').contains(currentUser!.email)){
                                        print('1.else if');
                                        Navigator.pushNamed(
                                            context, '/otherUserProfile',
                                            arguments: {
                                              'email': doc.get('email'),
                                              'email2': currentUser!.email,
                                              'username2': currentUser!.username,
                                            });
                                      }
                                      else if(!doc.get('followers').contains(currentUser!.email) && doc.get('profType') == true) { //private takip edilmiyor
                                        print('2.else if');
                                        Navigator.pushNamed(
                                            context, '/otherUserProfile',
                                            arguments: {
                                              'email': doc.get('email'),
                                              'email2': currentUser!.email,
                                              'username2': currentUser!.username,
                                            });
                                      }
                                      else if(!doc.get('followers').contains(currentUser!.email) && doc.get('profType') == false) { //private takip edilmiyor
                                        print('3.else if');
                                        Navigator.pushNamed(
                                            context, '/otherUserProfile',
                                            arguments: {
                                              'email': doc.get('email'),
                                              'email2': currentUser!.email,
                                              'username2': currentUser!.username,
                                            });
                                      }

                                       */

                                      print('button clicked');
                                    },
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
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  doc.get('header'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                  //style: kCardTextLabel,
                                ),
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    doc.get('description'),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black87,
                                    ),
                                    //style: kSubtitleLabel,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      updateForumData(doc.get('fid'));
                                    },
                                    icon: Icon(
                                      Icons.thumb_up,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                    label: Text(
                                      ' x ${doc.get('like')}',
                                      //style: kSubtitleLabel,
                                    ),
                                  ),

                                  SizedBox(width: 16,),

                                  IconButton(
                                    onPressed: () {},
                                    padding: EdgeInsets.all(0),
                                    iconSize: 14,
                                    splashRadius: 24,
                                    color: Colors.red,
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          buttonPressed();
        },
        label: Text('New Forum'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}
