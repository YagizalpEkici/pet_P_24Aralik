import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

//import com.facebook.FacebookSdk;
//import com.facebook.appevents.AppEventsLogger;


class login extends StatefulWidget {
  ///////////////////////////////////////////// down side is analytics
  const login({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _loginState createState () => _loginState();
}

class _loginState extends State<login> {

  String _message = '';
  String _alertmessage = '';

  get error => null;
  StackTrace? get stackTrace => null;

  void setMessage(String msg){
  setState(() {
  _message = msg;
  });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials'),
          content: SingleChildScrollView(
            child: Text(_alertmessage),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }

  Future <void> _setCurrentScreen() async
  {
    await widget.analytics.setCurrentScreen(screenName: 'login page');
    //setMessage('setCurrentScreen succeded');
  }

  Future <void> _setLogEvent() async
  {
    await widget.analytics.logEvent(
        name: 'pet_project_test',
        parameters: <String, dynamic>{
          'string': 'string',
          'int': 310,
          'long': 12231412,
          'double': 310.5,
          'bool': true,
        }
    );
    setMessage('CustomLog succeded');
  }

  /////////////////////////////////////// upside for analytics. rest is previous login things.

  final _formKey = GlobalKey<FormState>();
  String email ="";
  String pass = "";
  bool isChecked = false;
  AuthService auth = AuthService();


  @override
  void initState() {
    super.initState();
  }
  void buttonPressed() {
    print(email);
    print(pass);
  }

  void pagedirection() {
    Navigator.pushNamed(context, '/SignUp');
  }

  var loading = false;
  List<dynamic> followers = [];
  List<dynamic> followings = [];
  List<dynamic> posts = [];
  void logInWithFacebook() async{
    setState(() { loading = true;});

    try {
      final facebookLoginResult = await FacebookAuth.instance.login();
      final userData = await FacebookAuth.instance.getUserData();
      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance.collection('user').add({
        'bio': '',
        'birthYear': '2022',
        'breed': 'golden',
        'email': userData['email'],
        'followers':  followers,
        'following': followings,
        'name': userData['name'],
        'password': userData['password'],
        'petName': userData['name' + '_surname' + 'face'],
        'photoUrl': userData['picture']['data']['url'],
        'posts': posts,
        'profType': 'false',
        'sex': 'male',
        'surname': userData['name' + ' surname'],
        'username': userData['name' + '_Facebook'],
      });
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => homePage()),
              (route) => false);
    }
    on FirebaseAuthException catch (e) {
      var content = '';
      switch(e.code) {
        case 'account-exists-with-different-credential':
          content = 'This account exists with a different sign in provider';
          break;
        case 'invalid-credentials':
          content = 'Unknown error has occured';
          break;
        case 'operation-not-allowed':
          content = 'This operation is not allowed';
          break;
        case 'user-disabled':
          content = 'The user you tried to log into is disabled';
          break;
        case 'user-not-found':
          content = 'The user you tried to log into was not found';
          break;
      }
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text('Log in with Facebook failed'),
        content: Text(content),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Ok'))],
      ));
    }
    finally {
      setState(() {
        loading = false;
      });
    }
  }


  @override
  Widget build (BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      body: Padding(
        padding: Dimen.RegularPadding,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: Dimen.RegularPadding,
                          child: CircleAvatar(
                            child: ClipOval(
                              child:
                              Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                            ),
                            radius: 60,
                          ),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "E-mail",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: Dimen.Border,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value==null){
                            return 'email field cannot be empty!';
                          }
                          else{

                            if(value.isEmpty){
                              return 'email field cannot be empty';
                            }
                            if(!EmailValidator.validate(value)){
                              return 'please enter a valid email!';
                            }
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            email = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,

                        validator: (value) {
                          if(value == null) {
                            return 'Password field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            pass = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                /*
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: Dimen.RegularPadding,
                      child: Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text_color,
                        ),
                      ),
                    ),
                    Checkbox(
                      checkColor: AppColors.Background,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() async {
                          isChecked = value!;
                          FirebaseCrashlytics.instance.setCustomKey('str_key', 'checkbox');
                          FirebaseCrashlytics.instance.log("all test!!!!!!!!!!!!!!!!");
                          await FirebaseCrashlytics.instance.recordError(
                              error,
                              stackTrace,
                              reason: 'a fatal error',
                              // Pass in 'fatal' argument
                              fatal: true
                          );
                        });
                      },
                    ),
                  ],
                ),

                 */
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 5,),
                    IconButton(onPressed: (){
                      auth.googleSignIn();
                    },
                      icon: FaIcon(FontAwesomeIcons.google),),
                    SizedBox(width: 5,),
                    IconButton(onPressed: (){
                      logInWithFacebook();
                    },
                      icon: FaIcon(FontAwesomeIcons.facebookF),),
                  ],
                ),

                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://i.ebayimg.com/images/g/WIgAAOSwal5YIJHv/s-l300.jpg",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 200,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 80,),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                  return AppColors.login_button_Color; // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () async{
                              if(_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _setCurrentScreen();
                                dynamic result = await auth.loginWithMailAndPass(email, pass);

                                if(result == null) {
                                  _alertmessage = 'Please check your mail and password enter try again';
                                  _showMyDialog();
                                }
                                else {
                                  Navigator.pushNamed(context, '/homePage');
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging in')));
                                }
                              }
                            },
                            child: Text(
                              'login',
                              style:TextStyle(
                                fontSize: 30,
                                color: AppColors.Background,
                              ),
                            ),
                          ),

                          SizedBox(width: 80),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Divider(thickness: 2,color: AppColors.text_color,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.text_color,
                            ),
                          ),
                          TextButton(
                            onPressed: pagedirection,
                            child: Text(
                              'Sign up now',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.login_page_signup,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}