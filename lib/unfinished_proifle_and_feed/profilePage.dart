import 'package:flutter/material.dart';
import 'package:pet_project/profileAppBarPages/friendshipRequests.dart';
import 'package:pet_project/profileAppBarPages/options.dart';
import 'package:pet_project/unfinished_proifle_and_feed/HomeScreen.dart';
import 'package:pet_project/profileAppBarPages/editProfile.dart';
/*
void main(){
  runApp(MaterialApp(
    home: HomeScreen()
  ));
}
*/
class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);


  @override
  _profilePageState createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {


  int currentIndex = 0;


  void editProfile() {
    Navigator.pushNamed(context, '/editProfile');
  }

  void friendshipRequests() {
    Navigator.pushNamed(context, '/friendshipRequests');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'nameOfTheApp',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: -1,
            fontSize: 20,
          ),
        ),

        actions: [
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: editProfile,
          ),
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: friendshipRequests,
          ),

        ],

        centerTitle: true,
      ),
      body: PageView(
        //controller: pc,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: ChipBuilder(
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: CircleAvatar(
                        radius: 70,
                        child: ClipOval(
                            child: Image.network(
                                'https://cdn-1.motorsport.com/images/amp/YpN8nVN0/s1000/sergio-perez-red-bull-racing-1.jpg')
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget myChip(String label, Color color) {
    return Chip(
      label: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          )
      ),
    );
  }


  Widget ChipBuilder() {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 6,
      runSpacing: 6,
      children: [
        myChip('Follower', Color(0xFFff6666)),
        myChip('Breed', Color(0xFFff6666)),

      ],

    );
  }
}

