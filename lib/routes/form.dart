import 'package:flutter/material.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post.dart';
import 'package:pet_project/unfinished_proifle_and_feed/post_tile.dart';
import 'package:pet_project/utils/dimensions.dart';


class forum extends StatefulWidget {
  const forum({Key? key}) : super(key: key);

  @override
  _forumState createState() => _forumState();
  }

  class _forumState extends State<forum> {
  final _formKey = GlobalKey<FormState>();
  String pageRoute ='';
  List<Post> myPosts = [
  Post(text: 'a - KASJDBKASDASD-üsküdar', date: '22.12.2021', likeCount: 10, commentCount: 5),
  Post(text: 'ASFGASDGSADGASDG - KASJDBKASDASD/mamak', date: '22.12.2021', likeCount: 20, commentCount: 10),
  Post(text: 'ASDGASDGASDG - KASJDBKASDASD/kadıköy', date: '22.12.2021', likeCount: 30, commentCount: 15),
  Post(text: 'FDJDFGG - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
  Post(text: 'ASDGASDGASDG - Sakarya/KASJDBKASDASD', date: '25.12.2021', likeCount: 50, commentCount: 25),
  Post(text: 'SRBYUFNGHILNFKBG - KASJDBKASDASD/foça', date: '25.12.2021', likeCount: 60, commentCount: 30),
  Post(text: 'DBJFNGMHKLGNFB - KASJDBKASDASD/şişli', date: '22.12.2021', likeCount: 30, commentCount: 15),
  Post(text: 'DFUGNKYFBUYSV - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
  Post(text: 'FNBKVDTFDSCHE - Ankara/keçiören', date: '25.12.2021', likeCount: 50, commentCount: 25),
  Post(text: 'NIYLKBYDVHSCTRUR - İstanbul/beşiktaş', date: '25.12.2021', likeCount: 60, commentCount: 30),

  ];
  List<Post> myPosts2 = [
    Post(text: 'b - KASJDBKASDASD-üsküdar', date: '22.12.2021', likeCount: 10, commentCount: 5),
    Post(text: 'ASFGASDGSADGASDG - KASJDBKASDASD/mamak', date: '22.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'ASDGASDGASDG - KASJDBKASDASD/kadıköy', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'FDJDFGG - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'ASDGASDGASDG - Sakarya/KASJDBKASDASD', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'SRBYUFNGHILNFKBG - KASJDBKASDASD/foça', date: '25.12.2021', likeCount: 60, commentCount: 30),
    Post(text: 'DBJFNGMHKLGNFB - KASJDBKASDASD/şişli', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'DFUGNKYFBUYSV - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'FNBKVDTFDSCHE - Ankara/keçiören', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'NIYLKBYDVHSCTRUR - İstanbul/beşiktaş', date: '25.12.2021', likeCount: 60, commentCount: 30),

  ];
  List<Post> myPosts3 = [
    Post(text: 'c - KASJDBKASDASD-üsküdar', date: '22.12.2021', likeCount: 10, commentCount: 5),
    Post(text: 'ASFGASDGSADGASDG - KASJDBKASDASD/mamak', date: '22.12.2021', likeCount: 20, commentCount: 10),
    Post(text: 'ASDGASDGASDG - KASJDBKASDASD/kadıköy', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'FDJDFGG - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'ASDGASDGASDG - Sakarya/KASJDBKASDASD', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'SRBYUFNGHILNFKBG - KASJDBKASDASD/foça', date: '25.12.2021', likeCount: 60, commentCount: 30),
    Post(text: 'DBJFNGMHKLGNFB - KASJDBKASDASD/şişli', date: '22.12.2021', likeCount: 30, commentCount: 15),
    Post(text: 'DFUGNKYFBUYSV - İstanbul/KASJDBKASDASD', date: '25.12.2021', likeCount: 40, commentCount: 20),
    Post(text: 'FNBKVDTFDSCHE - Ankara/keçiören', date: '25.12.2021', likeCount: 50, commentCount: 25),
    Post(text: 'NIYLKBYDVHSCTRUR - İstanbul/beşiktaş', date: '25.12.2021', likeCount: 60, commentCount: 30),

  ];

  void next() {
    Navigator.pushNamed(context, '/head2');
  }
  void buttonPressed(int route) {
    if (route == 1) {
      print('1st button');
    }
    else if (route == 2) {
      print('2nd button');
    }
    else {
      print('3rd button');
    }
    setState(() {
      if(route == 1){
        pageRoute = 'one';
      }
      else if(route == 2) {
        pageRoute = 'two';
      }
      else {
        pageRoute = 'three';
      }

    });
  }
  @override
  void initState(){
    super.initState();
    print('initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum',
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
                        children: [
                          ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),

                          onPressed: () {
                            buttonPressed(1);
                          },child: Text('Head 1'),

                        ),
                          SizedBox(width: 70,),

                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                            onPressed: (){buttonPressed(2);},
                            child: Text('Head 2'),

                          ),
                          SizedBox(width: 70,),

                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),

                            onPressed: (){buttonPressed(3);},
                            child: Text('Head 3'),
                            

                            ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Divider(thickness: 2,color: Colors.black,),
                      Column(
                        children: [
                          if(pageRoute == 'one')...[
                            headOne(),]

                          else if(pageRoute == 'two')...[
                            headTwo(),]

                          else if(pageRoute == 'three')...[
                            headThree(),
                            ]
                          else...[
                            headOne()
                            ],

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
  Widget headOne()
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: myPosts.map(
                  (post) =>
                  PostTile(
                    post: post,
                    incrementLike: () {
                      setState(() {
                        post.likeCount++;
                      });
                    }, delete: () {  },
                  )
          ).toList(),
        ),
      ),
    );
  }
  Widget headTwo()
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: myPosts2.map(
                  (post) =>
                  PostTile(
                    post: post,
                    incrementLike: () {
                      setState(() {
                        post.likeCount++;
                      });
                    }, delete: () {  },
                  )
          ).toList(),
        ),
      ),
    );
  }
  Widget headThree()
  {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: myPosts3.map(
                  (post) =>
                  PostTile(
                    post: post,
                    incrementLike: () {
                      setState(() {
                        post.likeCount++;
                      });
                    }, delete: () {  },
                  )
          ).toList(),
        ),
      ),
    );
  }
}


