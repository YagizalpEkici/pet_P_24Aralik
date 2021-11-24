import 'package:flutter/material.dart';
import 'package:pet_project/routes/walkthrough.dart';
import 'package:pet_project/utils/colors.dart';


void main() => runApp(MaterialApp(
  //home: Welcome(),
  //initialRoute: '/login',
  routes: {
    '/': (context) => WalkThrough(),


  },
));
