import 'dart:core';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/followClass.dart';
import 'package:pet_project/firestore_related/followStatusClass.dart';
import 'package:pet_project/firestore_related/notifClass.dart';
import 'package:pet_project/firestore_related/reportclass.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/firestore_related/posts.dart';



import 'package:pet_project/unfinished_proifle_and_feed/navigation_drawer_widget.dart';
import 'package:uuid/uuid.dart';
var uuid = Uuid();

bool followButtonInitial = true;
bool pending = false;
bool followAccepted = false;
bool unfollow = false;


class publicotherprofilePage extends StatefulWidget {
  const publicotherprofilePage({Key? key}) : super(key: key);


  @override
  _publicotherprofilePageState createState() => _publicotherprofilePageState();
}

class _publicotherprofilePageState extends State<publicotherprofilePage> {

  int currentIndex = 0;
  void editProfile() {
    Navigator.pushNamed(context, '/editProfile');
  }

  void friendshipRequests() {
    Navigator.pushNamed(context, '/friendshipRequests');
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

  String statusUserMail = "";
  String statusSenderMail  = "";


  void _loadStatusInfo(BuildContext context, String uniuser, String? unisender) async {
    String temp = uniuser + unisender!;
    var x = await FirebaseFirestore.instance
        .collection('followStatus')
        .where('addedMail', isEqualTo: temp)
        .get();
    if(x.size >= 0){
      setState(() {
        print("buldu status u");
        statusSenderMail = x.docs[0]['senderMail'];
        statusUserMail = x.docs[0]['userMail'];
        pending = x.docs[0]['pending'];
        followAccepted = x.docs[0]['followAccepted'];
        followButtonInitial = x.docs[0]['followButtonInitial'];
        unfollow = x.docs[0]['unfollow'];
      });
    }
    else{
      followButtonInitial = true;
      pending = false;
      followAccepted = false;
      unfollow = false;
    }
  }

  Future<void> addFollowStatus(followStatusClass status) async {
    final CollectionReference stats = FirebaseFirestore.instance.collection('followStatus');
    //var post_ref = posts.doc();
    try {
      //
      await stats.doc(status.pid).set(status.toJson());
      print("null olmadı");
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print("null oldu");
      return null;
    }
  }



  final db = FirebaseFirestore.instance;
  void _loadUserInfo(BuildContext context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    var x = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: args['email'])
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
  List<dynamic> updateLike = [];
  void _loadUserProf(BuildContext context) async {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    var profPosts = await FirebaseFirestore.instance
        .collection('posts')
        .where('email', isEqualTo: args['email'])
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

  String page = "otherProfile";

  String id = uuid.v4();

  Future<void> addFollow(followClass follow) async {
    final CollectionReference folllowRequests = FirebaseFirestore.instance.collection('followRequest');
    //var post_ref = posts.doc();
    try {
      //
      await folllowRequests.doc(follow.pid).set(follow.toJson());
      print("null olmadı");
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print("null oldu");
      return null;
    }
  }

  Future<void> addNotif(notifClass notif) async {
    final CollectionReference notifs = FirebaseFirestore.instance.collection('notification');
    //var post_ref = posts.doc();
    try {
      //
      await notifs.doc(notif.pid).set(notif.toJson());
      print("null olmadı");
      //.then((value) => print("User Added"))
      //.catchError((error) => print("Failed to add user: $error"));
    } catch (e) {
      print("null oldu");
      return null;
    }
  }

  void report(String reportedMail) async {
    final CollectionReference reports = FirebaseFirestore.instance.collection('reports');
    //var post_ref = posts.doc();
    //try {
    reportclass newreport = reportclass(
        pid: id,
        reportedMail: reportedMail, postid: 'userReported'
    );
    //
    await reports.doc(newreport.pid).set(newreport.toJson());
    print("null olmadı");
    //.then((value) => print("User Added"))
    //.catchError((error) => print("Failed to add user: $error"));
    //} catch (e) {
    //print("null oldu");
    //return null;
    //}
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



  @override
  void initState() {
    super.initState();
    followButtonInitial = true;
    pending = false;
    followAccepted = false;
    unfollow = false;
    followButton();


  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;

    _loadUserInfo(context);
    _loadUserProf(context);
    _loadStatusInfo(context, email, FirebaseAuth.instance.currentUser!.email.toString());

    currentUser = user(
      username: username,
      name: name,
      surname: surname,
      followers: followers,
      following: following,
      password: password,
      posts: posts,
      bio: bio,
      photoUrl: photoUrl,
      profType: profType,
      email: email,
      petName: petName,
      birthYear: birthYear,
      sex: sex,
      breed: breed,
    );


    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepOrangeAccent,

        title: Text(
          currentUser!.username,
          style: TextStyle(
            color: Colors.black,
            letterSpacing: -1,
            fontSize: 24,
          ),
        ),

        actions: [


          IconButton(onPressed: () =>
              showDialog<String>(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(
                      title: const Text('Report User'),
                      content: const Text(
                          'You are about to report this user, are you sure? Contact us for further inquiry.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            final CollectionReference reports = FirebaseFirestore
                                .instance.collection('reports');
                            reportclass newreport = reportclass(
                                pid: id,
                                reportedMail: args['email'], postid: 'userReported'
                            );
                            //
                            await reports.doc(newreport.pid).set(
                                newreport.toJson());
                            print("null olmadı");
                            Navigator.pop(context, 'Yes');
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'No');
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ),
              ),
            icon: Icon(Icons.report),
          )
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
                                  onPressed: () {
                                    print(currentUser!.followers);
                                    Navigator.pushNamed(
                                        context, '/followerListPage',
                                        arguments: {
                                          'followerList': currentUser!.followers
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
                                backgroundImage: NetworkImage(
                                    'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
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
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/followingListPage',
                                        arguments: {
                                          'followingList': currentUser!
                                              .following,

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
                            margin: EdgeInsets.fromLTRB(58, 8, 70, 8),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //SizedBox(width: 17,),
                    ElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, '/chat');

                    },
                      child: Text('Message'),),

                    SizedBox(width: 0,),
                    ElevatedButton(
                      onPressed: () async {

                        id = uuid.v4();
                        if(followButtonInitial){
                          followClass newfollow = followClass(
                              senderMail: args['email2'],
                              senderusername: args['username2'],
                              userMail: email,
                              pid: id,
                              addedMail: email + args['email2']
                          );
                          notifClass newnotif = notifClass(
                              Photoid: '',
                              userName: '',
                              type: 'follow',
                              userMail: email,
                              senderMail: args['email2'],
                              pid: id,
                              sendername: args['username2'],
                              addedMail: email + args['email2']
                          );

                          followStatusClass newstatus = followStatusClass(
                              senderMail: args['email2'],
                              userMail: email,
                              addedMail: email + args['email2'],
                              pid: id,
                              pending: true,
                              followAccepted: false,
                              followButtonInitial: false,
                              unfollow: false);
                          addFollow(newfollow);
                          addNotif(newnotif);
                          addFollowStatus(newstatus);
                          setState(() {
                            pending = true;
                            followButtonInitial = false;
                            followAccepted = false;
                            unfollow = false;
                            _loadStatusInfo(context, email, FirebaseAuth.instance.currentUser!.email.toString());
                          });
                        }
                        else if(pending){
                          //destroy follow status, follow request
                          String statusId = "";
                          var dbstatusGetter = await FirebaseFirestore.instance.collection('followStatus').where('addedMail', isEqualTo: email + args['email2']).get();
                          dbstatusGetter.docs.forEach((doc) => {
                            statusId = doc.id
                          });

                          FirebaseFirestore.instance
                              .collection('followStatus')
                              .doc(statusId)
                              .delete();
                          FirebaseFirestore.instance
                              .collection('notification')
                              .doc(statusId)
                              .delete();

                          FirebaseFirestore.instance
                              .collection('followRequest')
                              .doc(statusId)
                              .delete();

                          setState(() {
                            pending = false;
                            followButtonInitial = true;
                            followAccepted = false;
                            unfollow = false;
                            _loadStatusInfo(context, email, FirebaseAuth.instance.currentUser!.email.toString());
                          });
                        }

                        else if(followAccepted){
                          //destroy follow status, notif, follow request
                          //else
                          String statusId = "";
                          var dbstatusGetter = await FirebaseFirestore.instance.collection('followStatus').where('addedMail', isEqualTo: email + args['email2']).get();
                          dbstatusGetter.docs.forEach((doc) => {
                            statusId = doc.id
                          });
                          FirebaseFirestore.instance
                              .collection('followStatus')
                              .doc(statusId)
                              .update({
                            "addedMail": 'AAAAAAAAAAAAAAAAAAAAA',
                            "pending": false,
                            "followButtonInitial": true,
                            "unfollow": false,
                            "followAccepted": false
                          });
                          List<dynamic> updatedUserfollower = [];
                          List<dynamic> updatedSenderfollowing = [];

                          var dbUsergetter = await FirebaseFirestore.instance
                              .collection('user')
                              .where('email', isEqualTo: email)
                              .get();
                          var dbSendergetter = await FirebaseFirestore.instance
                              .collection('user')
                              .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
                              .get();
                          updatedSenderfollowing = dbSendergetter.docs[0]['following'];
                          updatedUserfollower = dbUsergetter.docs[0]['followers'];

                          updatedUserfollower.remove(FirebaseAuth.instance.currentUser!.email);
                          updatedSenderfollowing.remove(email);

                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(email)
                              .update({
                            "followers": updatedUserfollower
                          });
                          FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({
                            "following": updatedSenderfollowing
                          });

                          setState(() {
                            followButtonInitial = true;
                            pending = false;
                            followAccepted = false;
                            unfollow = false;
                            _loadStatusInfo(context, email, FirebaseAuth.instance.currentUser!.email.toString());
                          });


                        }else{
                          //destroy follow status, notif, follow request
                          setState(() {
                            _loadStatusInfo(context, email, FirebaseAuth.instance.currentUser!.email.toString());
                          });
                        }

                      },
                      child:followButton(),)
                  ],
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
                      if (doc.get('email') == currentUser!.email) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ListTile(
                                leading: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Image.network(
                                      'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                                  color: Colors.white,
                                  onPressed: () { //TODO
                                  },
                                ),
                                title: Text(currentUser!.username),
                                subtitle: Text(
                                  ('$date'),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  doc['content'],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),

                              Image.asset('assets/image1.jpg'),
                              ButtonBar(
                                alignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              14),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.thumb_up),
                                    onPressed: () {
                                      if (!doc.get('likes').contains(currentUser!.email)) {
                                        updateForumData(doc.get('pid'),
                                            currentUser!.email, updateLike);
                                      }
                                      // Perform some action

                                    },
                                    label: Text('${doc.get('likes').length}'),
                                  ),


                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              14),
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

                                  //deleteIfPostYours(currentUser!.email, doc.get('email'),doc.get('pid')),
                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.report,
                                    ),
                                    onPressed: () async {
                                      if(currentUser!.email == doc.get('email'))
                                      {
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
                                      }
                                      else {
                                        _showMyDialog();
                                      }
                                      // Perform some action
                                    },
                                    label: const Text(''),
                                  ),

                                  ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purpleAccent),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    icon: Icon(Icons.share_outlined),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/reSharePage', arguments: {'postPhotoURL': doc.get('postPhotoURL'), 'content':doc.get('content')});
                                      // Perform some action
                                    },
                                    label: const Text('R'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      else {
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
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You can not delete the post that your are not owned.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('I understand'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget followButton(){
    if(followButtonInitial == true){
      return Text('follow');
    }
    else if(pending == true){
      return Text('pending');
    }
    else if(followAccepted == true){
      return Text('unfollow');
    }
    else{
      return Text('follow');
    }
  }

}