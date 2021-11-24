import 'package:flutter/material.dart';
import 'package:pet_project/routes/walkthrough.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/routes/loginpage.dart';


void main() => runApp(MaterialApp(
  //home: Welcome(),
  initialRoute: '/walk',
  routes: {
    '/walk': (context) => WalkThrough(),
    '/login': (context) => login(),


  },
));
