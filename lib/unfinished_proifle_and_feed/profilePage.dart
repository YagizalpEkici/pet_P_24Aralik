import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:pet_project/profileAppBarPages/friendshipRequests.dart';
import 'package:pet_project/profileAppBarPages/options.dart';
import 'package:pet_project/unfinished_proifle_and_feed/HomeScreen.dart';
import 'package:pet_project/profileAppBarPages/editProfile.dart';

import 'custom_sidebar_drawer.dart';
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

  FSBStatus _fsbStatus = FSBStatus.FSB_CLOSE;


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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        leading: IconButton(icon:Icon(Icons.menu),
            onPressed:() {setState(() {
            _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ?
            FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
            });}//Navigator.pushNamed(context, '/homePage')
        ),
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
            icon: Icon(Icons.edit),
            onPressed: editProfile,
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: friendshipRequests,
          ),
        ],

        centerTitle: true,
      ),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.white,
        drawer: CustomSidebarDrawer(drawerClose: (){
          setState(() {
            _fsbStatus = FSBStatus.FSB_CLOSE;
          });
        },
        ),
        screenContents: profileScreen(),
        status: _fsbStatus,
      ),
    );
  }

  Widget profileScreen(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Chip(
                            label:
                            Container(
                              width: 80,
                              height: 20,
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Text('Breed',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                          Chip(
                            label:
                            Container(
                              width: 80,
                              height: 20,

                            ),
                          ),
                        ],

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

                      Column(
                        children: [
                          Row(
                            children: [
                              Text('Following',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                          Chip(
                            label:
                            Container(
                              width: 80,
                              height: 20,
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              Text('Age',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                          Chip(
                            label:
                            Container(
                              width: 80,
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),),
                      color: Colors.grey[300],
                      elevation: 8,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'asjldfnasjofosfnajsfasjbafjjnaskjfnasjbflasjbfasbnfkajsbfkajsbfkjasbfkajsbfkajsbfkjasbfkajsbfkjasbfjaksf'
                                  'laksfnlasknflkasnflkasnflkanslkfnaslkfnalsknfas'
                                  'fasknflaksnflkasnflaksnflkasnflnaslfknaslkfnas'
                                  'fıasnflkansflanslfjnasljfnajslkasldknaşslkfjbljaskdbflkjsabdfjkasbdfasdffajskbf',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,

                              ),
                            ),
                          ),

                        ],
                      ),
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
                Divider(thickness: 4,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Column(
            children: [

            ],
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
