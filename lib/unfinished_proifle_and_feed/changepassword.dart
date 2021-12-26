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

class changepassword extends StatefulWidget {
  const changepassword({Key? key}) : super(key: key);

  @override
  _changepasswordState createState() => _changepasswordState();
}

class _changepasswordState extends State<changepassword> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: Dimen.RegularPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "Current password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: Dimen.Border,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "New Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: Dimen.Border,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "Retype your new password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: Dimen.Border,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Apply Changes'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
