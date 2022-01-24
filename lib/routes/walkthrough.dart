import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class WalkThrough extends StatefulWidget {

  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {

  int currentPage = 0;
  int lastPage = 4;
  List<String> title = ['WELCOME','PROFILE','SHARE MOMENTS','USE FORUM','LET\'S BEGIN'];
  List<String> heading = ['RASPIE','Create your pet account','Share your pet\'s best moments','Interact with other pet owners via forums','Let\'s get it started'];
  List<String> images = [
    'https://cdn.pixabay.com/photo/2020/03/16/16/10/fox-4937513_960_720.png',
    'https://cdn.pixabay.com/photo/2021/03/02/19/34/border-collie-6063639_960_720.png',
    'https://cdn.pixabay.com/photo/2013/10/19/03/01/dog-197719_960_720.jpg',
    'https://www.hiveage.com/blog/wp-content/uploads/2015/06/reputation-management-small-business.jpg',
    'https://listelist.com/wp-content/uploads/2017/05/heyecanlanan_kopek-620x375.jpg'];
  List<String> captions = ['',
    'Create an account for your dog upload her best profile photo and give her a nickname',
    'Share best moments of your pet',
    'Use pet forum to interact with lots of pet owners. Ask them anything!',
    'Shall we begin?'];

  void nextPage() {
    if(currentPage < lastPage && currentPage != 6) {
      setState(() {
        currentPage += 1;
      });
    }
    else{
      Navigator.pushNamed(context, '/login');
    }
  }
  void prevPage() {
    if(currentPage > 0) {
      setState(() {
        currentPage -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        title: Text(
          title[currentPage].toUpperCase(),
          style: TextStyle(
            color: AppColors.wThroughHeadline,
            letterSpacing: -1,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(

        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    heading[currentPage],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      color: AppColors.text_color,
                      letterSpacing: -1.0,
                    ),
                  ),
                ),
              ),
              Container(
                height: 280,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(images[currentPage]),
                  radius: 140,
                  backgroundColor: Colors.black,
                ),
              ),
              Center(
                child: Text(
                  captions[currentPage],
                  textAlign: TextAlign.center,
                  style: TextStyle(

                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF757575),
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 80,
                  child: Row(
                    children: [
                      OutlinedButton(
                          onPressed: prevPage,
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: AppColors.text_color,
                            ),
                          )
                      ),

                      Spacer(),

                      Text(
                        '${currentPage+1}/${lastPage+1}',
                        style: TextStyle(
                          color: AppColors.wThroughHeadline,


                        ),
                      ),

                      Spacer(),

                      OutlinedButton(

                          onPressed: nextPage,

                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: AppColors.text_color,
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
