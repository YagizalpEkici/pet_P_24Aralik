import 'package:flutter/material.dart';
import 'package:pet_project/profileAppBarPages/friendshipRequests.dart';
import 'package:pet_project/profileAppBarPages/options.dart';
import 'package:pet_project/unfinished_proifle_and_feed/HomeScreen.dart';
import 'package:pet_project/profileAppBarPages/editProfile.dart';
import 'package:pet_project/routes/homePage.dart';
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
        leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pushNamed(context, '/homePage')
        ),
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
            icon: Icon(Icons.add_circle),
            onPressed: editProfile,
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: friendshipRequests,
          ),

        ],

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Follower',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Chip(
                                label:
                                Container(
                                  width: 60,
                                  height: 20,
                                ),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text('Breed',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                              Chip(
                                label:
                                Container(
                                  width: 60,
                                  height: 20,

                                ),
                              ),
                            ],

                          ),
                          Padding(
                            padding: const EdgeInsets.all(14),
                            child: CircleAvatar(
                              radius: 60,
                              child: ClipOval(
                                  child: Image.network(
                                      'https://cdn-1.motorsport.com/images/amp/YpN8nVN0/s1000/sergio-perez-red-bull-racing-1.jpg')
                              ),
                            ),
                          ),

                          Column(
                            children: [
                              Row(
                                children: [
                                  Text('Following',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                              Chip(
                                label:
                                Container(
                                  width: 60,
                                  height: 20,
                                ),
                              ),
                              SizedBox(height: 15,),
                              Row(
                                children: [
                                  Text('Age',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                              Chip(
                                label:
                                Container(
                                  width: 60,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Bio',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Chip(
                        label:
                        Container(
                          width: 350,
                          height: 20,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('POSTS',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Divider(thickness: 4,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text('POSTS',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
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

