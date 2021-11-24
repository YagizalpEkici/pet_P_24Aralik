import 'package:flutter/material.dart';
import 'package:pet_project/loginpage.dart';



void main() => runApp(MaterialApp(
  //home: Welcome(),
  initialRoute: '/login',
  routes: {
    '/login': (context) => login(),
  },
));
