import 'package:flutter/material.dart';
import 'package:pet_project/routes/walkthrough.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/routes/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';

void main() => runApp(MaterialApp(
  home: Splash(),
  routes: {
    '/walk': (context) => WalkThrough(),
    '/login': (context) => login(),
  },
));

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (preferences.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new login()));
    } else {
      await preferences.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new WalkThrough()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    );
  }
}