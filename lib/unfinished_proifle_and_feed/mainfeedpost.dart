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

import 'navigation_drawer_widget.dart';


Widget mainfeedpost(){
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: const Text('Username'),
          subtitle: Text(
            '26.12.2021',
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
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
                // Perform some action
              },
              label: const Text('Like'),
            ),

            ElevatedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              icon: Icon(Icons.comment),
              onPressed: () {
                // Perform some action
              },
              label: const Text('Comment'),
            ),

            ElevatedButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
              icon: Icon(Icons.share),
              onPressed: () {
                // Perform some action
              },
              label: const Text('Share'),

            ),
          ],
        ),
      ],
    ),
  );
}
