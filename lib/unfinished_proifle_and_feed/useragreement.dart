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

class useragreement extends StatelessWidget {
  const useragreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USER AGREEMENT'),
        centerTitle: true,
      ),
      body: SafeArea(

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children:[
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                      radius: 100,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  Divider(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'ONLY AGREEMENT',
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        fontSize: 24,
                        color: const Color(0xFF757575),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Make your pet life happy. Be kind to animals',
                      textAlign: TextAlign.center,
                      style: TextStyle(

                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF757575),
                        letterSpacing: -1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
