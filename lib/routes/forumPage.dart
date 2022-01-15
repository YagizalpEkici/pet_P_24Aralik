import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';
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
                                  CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 30,
                                    backgroundImage: NetworkImage('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
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
                              Row(
                                children: [
                                  Text(
                                    doc.get('description'),
                                    style: TextStyle(
                                      fontSize: 14,
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
