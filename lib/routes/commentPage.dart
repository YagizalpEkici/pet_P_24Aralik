import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_project/firestore_related/posts.dart';

import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _formKey = GlobalKey<FormState>();


  void buttonPressed(postId) {
    final args2 = ModalRoute.of(context)!.settings.arguments as Map;
    Navigator.pushNamed(context, '/generateComment', arguments: {'pid':postId, 'page':args2['page']});
  }
  String comment = "";
  String Commentemail = "";
  String cid = "";
  String Commentpid = "";

  void _loadCommentInfo() async {

    var x = await FirebaseFirestore.instance
        .collection('comments')
        .get();

    setState(() {
      comment = x.docs[0]['comment'];
      Commentemail=x.docs[0]['Commentemail'];
      cid=x.docs[0]['cid'];
      Commentpid=x.docs[0]['pid'];
    });
  }


  DateTime? date;
  String postPhotoURL = "";
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  String content = "";
  Post? currentPost;
  int postsSize = 0;
  String username = "";
  String userPhotoUrl = "";
  String email ="";
  String pid = "";

  void _loadPosts(postId) async {
    var profPosts = await FirebaseFirestore.instance
        .collection('posts')
        .where('pid', isEqualTo: postId)
        .get();


    postsSize = profPosts.size;
    username = profPosts.docs[0]['username'];
    pid = profPosts.docs[0]['pid'];
    date= DateTime.fromMillisecondsSinceEpoch(profPosts.docs[0]['date'].seconds * 1000);
    userPhotoUrl= profPosts.docs[0]['userPhotoUrl'];
    content= profPosts.docs[0]['content'];
    email= profPosts.docs[0]['email'];
    comments= profPosts.docs[0]['comments'];
    likes= profPosts.docs[0]['likes'];
    //postPhotoURL= profPosts.docs[0]['postPhotoURL'];
    postPhotoURL = 'assets/image1.jpg';

    //posts..sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      print("its in");
    });
  }

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadCommentInfo();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    String postId = args['pid'];
    _loadPosts(postId);
    currentPost = Post (
      username: username,
      pid: pid,
      date: DateTime.now(),
      userPhotoUrl: userPhotoUrl,
      content: content,
      email: email,
      comments: comments,
      likes: likes,
      postPhotoURL: 'assets/image1.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
          //onPressed:() => exit(0),
        ),
        title: Text(
          'COMMENTs',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('comments').snapshots(),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 690,
                  child: ListView(
                    children: snapshot.data!.docs.map((doc) {
                      if(currentPost!.comments.contains(doc.get('cid'))) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shadowColor: Colors.amber,
                          elevation: 8,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 25,
                                      backgroundImage: NetworkImage('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      doc.get('Commentusername') + ' -> commented on this post',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(thickness: 1,color: Colors.black,),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        doc.get('comment'),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                        //style: kSubtitleLabel,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          buttonPressed(postId);
        },
        label: Text('New Comment'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}