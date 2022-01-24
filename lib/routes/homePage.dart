import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:pet_project/routes/search.dart';
import 'package:pet_project/unfinished_proifle_and_feed/HomeScreen.dart';
import 'package:pet_project/unfinished_proifle_and_feed/profilePage.dart';
import 'package:pet_project/routes/forumPage.dart';

import 'package:pet_project/routes/form.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currentIndex = 0;
  final screens = [
    HomeScreen(),
    SearchPage(),
    forumPage(),
    profilePage(),
    //forum(),

  ];
  //PageController pageController = PageController();

  void onTapped(int index){
    setState((){
      currentIndex = index;
    });
    //pageController.jumpToPage(index);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(items: const < BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label:'search'),
        BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label:'forum'),
        //BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label:'form'),
        BottomNavigationBarItem(icon: Icon(Icons.pets_outlined), label:'profile'),

      ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.deepOrangeAccent,

          unselectedItemColor: Colors.orange,
          onTap: onTapped
      ),
    );
  }
}
