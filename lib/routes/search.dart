import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:pet_project/unfinished_proifle_and_feed/custom_sidebar_drawer.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  FSBStatus _fsbStatus = FSBStatus.FSB_CLOSE;
  String searchedName = "";
  final List<String> SearchResults = ['Bobby', 'Fluffy', 'Daisy', 'Rex', 'Suzzie', 'Princess', 'Snowball', 'T-rex'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.menu),
          onPressed:() {
            setState(() {
              _fsbStatus = _fsbStatus == FSBStatus.FSB_OPEN ?
              FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
            });
          }//Navigator.pushNamed(context, '/homePage')
        ),
        title: Text(
          'SEARCH',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body:FoldableSidebarBuilder(
      drawerBackgroundColor: Colors.white,
      drawer: CustomSidebarDrawer(drawerClose: (){
        setState(() {
          _fsbStatus = FSBStatus.FSB_CLOSE;
        });
      },
      ),
      screenContents: searchScreen(),
      status: _fsbStatus,
    ),


    );
  }
  Widget searchScreen() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child:TextFormField(
                  decoration: InputDecoration(
                    fillColor: AppColors.app_icons,
                    filled: true,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ), // icon is 48px widget.
                    ),
                    hintText: "Search for a user",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.text_color,
                      ),
                      borderRadius: Dimen.Border,
                    ),
                  ),
                  onSaved: (value){
                    if(value != null){
                      searchedName = value;
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}