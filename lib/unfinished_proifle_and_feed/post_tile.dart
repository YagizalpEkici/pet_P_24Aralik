import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';

class PostTile extends StatelessWidget {

  final Post post;
  final VoidCallback incrementLike;

  const PostTile({
    required this.post,
    required this.incrementLike
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shadowColor: Colors.amber,
      elevation: 12,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                post.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                //style: kCardTextLabel,
              ),
            ),

            Row(
              children: [
                Text(
                  post.date,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                Spacer(),

                TextButton.icon(
                  onPressed: incrementLike,
                  icon: Icon(
                    Icons.thumb_up,
                    color: Colors.green,
                    size: 17,
                  ),
                  label: Text(
                    ' x ${post.likeCount}',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    //style: kSubtitleLabel,
                  ),
                ),

                SizedBox(width: 16,),

                Icon(
                  Icons.comment,
                  size: 17,
                  color: Colors.red,
                ),

                Text(
                  ' x ${post.commentCount}',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  //style: kSubtitleLabel,
                ),

                SizedBox(width: 16,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}