import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final _formKey = GlobalKey<FormState>();
  String searchedName = "";
  final List<String> SearchResults = ['Bobby', 'Fluffy', 'Daisy', 'Rex', 'Suzzie', 'Princess', 'Snowball', 'T-rex','Bobby', 'Fluffy', 'Daisy', 'Daisy', 'Rex', 'Suzie', 'Princess', 'Snowball'];
  String url = 'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        child: Column(
          children: <Widget>[
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
                                  return "Give username";
                                }
                                return null;
                              },
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
                              onChanged: (value){
                                searchedName = value;
                              },
                            ),
                          ),
                          IconButton(onPressed: () {
                            print('Button pressed');
                            if (_formKey.currentState!.validate()) {
                              print('Everythhing is good o go!');
                              print(searchedName);
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

            Expanded(
              child: ListView.builder(
                itemCount: SearchResults.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                    child: SizedBox(
                      height: 55, width: 100,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: ClipOval(
                            child: Image.network(url),
                          ),
                          radius: 25,
                        ),
                        title: Text(SearchResults[index],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}