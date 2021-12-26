import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/unfinished_proifle_and_feed/mainfeedpost.dart';
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
import 'package:pet_project/unfinished_proifle_and_feed/mainfeedpost.dart';

import 'navigation_drawer_widget.dart';






class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> myPostsmain = [
    Post(text: 'Hello World 1', date: '22.10.2021', likeCount: 10, commentCount: 5),
    Post(text: 'Hello World 2', date: '22.10.2021', likeCount: 20, commentCount: 10),
    Post(text: 'Hello World 3', date: '22.10.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Hello World 4', date: '25.10.2021', likeCount: 40, commentCount: 20),
    Post(text: 'Hello World 5', date: '25.10.2021', likeCount: 50, commentCount: 25),
    Post(text: 'Hello World 6', date: '25.10.2021', likeCount: 60, commentCount: 30),
  ];

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImageCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        ),

        drawer: NavigationDrawerWidget(),
        body:Padding(
          padding: Dimen.RegularPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(onPressed: () {
                      Navigator.pushNamed(context, '/addphoto');
                    },
                      icon: Icon(Icons.add_photo_alternate),
                      label: Text('Add Photo'),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    ElevatedButton.icon(onPressed: pickImageCamera,
                      icon: Icon(Icons.add_a_photo),
                      label: Text('Take Photo'),
                    ),
                    SizedBox(
                      width: 9,
                    ),
                    /*
                    ElevatedButton.icon(onPressed: () {

                    },
                      icon: Icon(Icons.send),
                      label: Text('Status'),
                    ),
                    */
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                    height: 460, width: 379,
                        child: mainfeedpost()),
                  ],
                )
              ],
            ),
          ),
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
