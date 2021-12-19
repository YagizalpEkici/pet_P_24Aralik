import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/auth.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_project/routes/createPetProfile.dart';
import 'package:pet_project/routes/homePage.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

import 'custom_sidebar_drawer.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FSBStatus _fsbStatus = FSBStatus.FSB_CLOSE;
  List<Post> myPosts = [
    Post(text: 'Hello World 1', date: '22.10.2021', likeCount: 10, commentCount: 5),
    Post(text: 'Hello World 2', date: '22.10.2021', likeCount: 20, commentCount: 10),
    Post(text: 'Hello World 3', date: '22.10.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Hello World 4', date: '25.10.2021', likeCount: 40, commentCount: 20),
    Post(text: 'Hello World 5', date: '25.10.2021', likeCount: 50, commentCount: 25),
    Post(text: 'Hello World 6', date: '25.10.2021', likeCount: 60, commentCount: 30),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          //backgroundColor: Colors.red[400],
          //title: Text("Flutter Foldable Sidebar Demo") ,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: (){
              setState(() {
                _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ?
                FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              });
            },
          ),
        ),
        body: FoldableSidebarBuilder(
          drawerBackgroundColor: Colors.white,
          drawer: CustomSidebarDrawer(drawerClose: (){
            setState(() {
              _fsbStatus = FSBStatus.FSB_CLOSE;
            });
          },
          ),
          screenContents: feedScreen(),
          status: _fsbStatus,
        ),
      ),
    );
  }


  Widget feedScreen() {
    return Padding(
      padding: Dimen.RegularPadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(onPressed: () {

                },
                  icon: Icon(Icons.add_photo_alternate),
                  label: Text('Add Photo'),
                ),
                SizedBox(
                  width: 9,
                ),
                ElevatedButton.icon(onPressed: () {

                },
                  icon: Icon(Icons.add_a_photo),
                  label: Text('Take Photo'),
                ),
                SizedBox(
                  width: 9,
                ),
                ElevatedButton.icon(onPressed: () {

                },
                  icon: Icon(Icons.send),
                  label: Text('Status'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
