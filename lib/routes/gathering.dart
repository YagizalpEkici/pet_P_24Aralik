import 'package:flutter/material.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post_tile.dart';
import 'package:pet_project/routes/GenerateGathering.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';

class gathering extends StatefulWidget {
  const gathering({Key? key}) : super(key: key);

  @override
  State<gathering> createState() => _gatheringState();
}

class _gatheringState extends State<gathering> {
  final _formKey = GlobalKey<FormState>();
  List<Post> myPosts = [
    Post(text: 'Gathering1 - İstanbul-üsküdar', date: '22.12.2021', likeCount: 10, commentCount: 5),
    Post(text: 'Gathering2 - Ankara/mamak', date: '22.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'Gathering3 - İstanbul/kadıköy', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Gathering4 - İstanbul/taksim', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'Gathering5 - Sakarya/sapanca', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'Gathering6 - İzmir/foça', date: '25.12.2021', likeCount: 60, commentCount: 30),
    Post(text: 'Gathering7 - İstanbul/şişli', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'Gathering8 - İstanbul/sarıyer', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'Gathering9 - Ankara/keçiören', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'Gathering10 - İstanbul/beşiktaş', date: '25.12.2021', likeCount: 60, commentCount: 30),
  ];
  String searchedGathering = "";

  void buttonPressed() {
    Navigator.pushNamed(context, '/gatherings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Gathering',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child:TextFormField(
                              validator: (value) {
                                if (value!.length == 0) {
                                  return "Enter a location";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.white30,
                                filled: true,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: Icon(
                                    Icons.map_outlined,
                                    color: Colors.black87,
                                  ), // icon is 48px widget.
                                ),
                                hintText: "Search for a gathering",
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black87,
                                  ),
                                  borderRadius: Dimen.Border,
                                ),
                              ),
                              onChanged: (value){
                                searchedGathering = value;
                              },
                            ),
                          ),
                          IconButton(onPressed: () {
                            print('Button pressed');
                            if (_formKey.currentState!.validate()) {
                              print('Everything is good o go!');
                              print(searchedGathering);
                            } else {
                              print('Something wrong!');
                            }
                          },
                            icon: Icon(
                              Icons.search,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(thickness: 2,color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: myPosts.map(
                        (post) =>
                        PostTile(
                          post: post,
                          incrementLike: () {
                            setState(() {
                              post.likeCount++;
                            });
                          },
                        )
                ).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          buttonPressed();
        },
        label: Text('New Gathering'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}