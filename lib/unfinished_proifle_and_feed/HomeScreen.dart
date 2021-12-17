/*
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  PageController pageController = PageController();

  void onTapped(int index){
    setState((){
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(
            color: Colors.black,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.green,
          ),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(items: const < BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label:'mainFeed'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label:'search'),
        BottomNavigationBarItem(icon: Icon(Icons.meeting_room), label:'gathering'),
        BottomNavigationBarItem(icon: Icon(Icons.pending_actions), label:'form'),
        BottomNavigationBarItem(icon: Icon(Icons.accessibility), label:'profile'),

      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.red,
          onTap: onTapped
      ),
    );
  }
}

 */

