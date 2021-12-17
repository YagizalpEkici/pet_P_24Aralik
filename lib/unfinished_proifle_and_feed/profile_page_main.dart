import 'package:flutter/material.dart';
import 'package:profile_page_v2/profilePage.dart';

import '../routes/HomeScreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: profilePage(),
    );
  }
}
