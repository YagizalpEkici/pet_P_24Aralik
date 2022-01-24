import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pet_project/firestore_related/SearchResult.dart';
import 'package:pet_project/routes/searchCard.dart';
import 'package:pet_project/firestore_related/users.dart';
import 'package:pet_project/routes/otherUserProfile.dart';

user? searchUser;
bool check = false;
class SearchPage extends StatefulWidget {
  @override
  _SearchPage createState() => new _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  user? currentUser;
  final _formKey = GlobalKey<FormState>();
  String SearchedName ="";
  final db = FirebaseFirestore.instance;
  String password="";
  String name="";
  String surname="";
  String petName="";
  String sex="";
  List<dynamic> followers = [];
  List<dynamic> following = [];
  String bio = "",
      username = "",
      breed = "",
      photoUrl = "",
      birthYear = "";
  List<dynamic> postsUser = [];
  bool profType=true;
  List<dynamic> posts = [];
  String email ="";

  String password2="";
  String name2="";
  String surname2="";
  String petName2="";
  String sex2="";
  List<dynamic> followers2 = [];
  List<dynamic> following2 = [];
  String bio2 = "",
      username2 = "",
      breed2 = "",
      photoUrl2 = "",
      birthYear2 = "";
  List<dynamic> postsUser2 = [];
  bool profType2=true;
  List<dynamic> posts2 = [];
  String email2 ="";

  DateTime? date;
  String postPhotoURL = "";
  List<dynamic> comments = [];
  List<dynamic> likes = [];
  String content = "";
  String pid = "";
  List<String> userResults = [];

  void _loadCUserInfo() async {
    FirebaseAuth _auth;
    User? _user;
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    var x = await FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: _user?.email)
        .get();

    setState(() {
      username2 = x.docs[0]['username'];
      password2=x.docs[0]['password'];
      name2=x.docs[0]['name'];
      surname2=x.docs[0]['surname'];
      followers2 = x.docs[0]['followers'];
      following2 = x.docs[0]['following'];
      sex2=x.docs[0]['sex'];
      petName2=x.docs[0]['petName'];
      photoUrl2 = x.docs[0]['photoUrl'];
      bio2 = x.docs[0]['bio'];
      breed2 = x.docs[0]['breed'];
      birthYear2 = x.docs[0]['birthYear'];
      email2=x.docs[0]['email'];
      posts2=x.docs[0]['posts'];
      profType2=x.docs[0]['profType'];

    });
  }


  void _loadUserInfo(search) async {

    var x = await FirebaseFirestore.instance
        .collection('user')
        .where('username', isEqualTo: search)
        .get();

    setState(() {
      username = x.docs[0]['username'];
      password=x.docs[0]['password'];
      name=x.docs[0]['name'];
      surname=x.docs[0]['surname'];
      followers = x.docs[0]['followers'];
      following = x.docs[0]['following'];
      sex=x.docs[0]['sex'];
      petName=x.docs[0]['petName'];
      photoUrl = x.docs[0]['photoUrl'];
      bio = x.docs[0]['bio'];
      breed = x.docs[0]['breed'];
      birthYear = x.docs[0]['birthYear'];
      email=x.docs[0]['email'];
      posts=x.docs[0]['posts'];
      profType=x.docs[0]['profType'];

    });
  }

  void getSearchResults(query) async {

    var users = await FirebaseFirestore.instance
        .collection("user")
        .where('username', isGreaterThanOrEqualTo: query,

      isLessThan: query.substring(0, query.length - 1) +
          String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),

    )
        .get();
    users.docs.forEach((doc) => {
      userResults.add(
        doc['username']
      )
    });

    setState(() {
      SearchedName = query;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCUserInfo();

    //takeSearchValue();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = user(
      username: username2,
      name: name2,
      surname: surname2,
      followers: followers2,
      following: following2,
      password: password2,
      posts: posts2,
      bio: bio2,
      photoUrl: 'https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png',
      profType: profType2,
      email:email2,
      petName: petName2,
      birthYear: birthYear2,
      sex: sex2,
      breed: breed2,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        automaticallyImplyLeading: false,
        title: Text('Search a User'),
        centerTitle: true,

      ),
      body: Container(
        height: 300,
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
                                SearchedName = value;
                              },
                            ),
                          ),
                          IconButton(onPressed: () async{
                            print('Button pressed');

                            if (_formKey.currentState!.validate()) {
                              print('Everything is good to go!');
                              //print(SearchedName);

                              getSearchResults(SearchedName);
                              if(userResults.isEmpty) {
                                print('it is empty');
                                check = false;
                              }
                              else {
                                check = true;
                                print('before loading');
                                _loadUserInfo(SearchedName);
                                searchUser = user(
                                  username: username,
                                  name: name,
                                  surname: surname,
                                  followers: followers,
                                  following: following,
                                  password: password,
                                  posts: posts,
                                  bio: bio,
                                  photoUrl: photoUrl,
                                  profType: profType,
                                  email:email,
                                  petName: petName,
                                  birthYear: birthYear,
                                  sex: sex,
                                  breed: breed,
                                );
                                print('after loading username-> ' + searchUser!.username );
                              }
                              userResults = [];
                            }
                            else {
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
                      buildResultCard(searchUser?.username,searchUser?.petName,searchUser?.photoUrl,email,email2,username2,context),
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
  Widget buildResultCard(username,petName,photoUrl,mail,mail2,username2,BuildContext context) {
    print('inside widget');
    if(check) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 8),
        shadowColor: Colors.amber,
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                      color: Colors.white,
                      onPressed: () {
                        if(currentUser!.following.contains(mail)){
                          Navigator.pushNamed(context, '/otherUserProfile', arguments: {'email':mail, 'email2':mail2, 'username2':username2});
                        }
                        else if(searchUser?.profType == true){
                          Navigator.pushNamed(
                              context, '/privateOtherProfile',
                              arguments: {
                                'email': mail,
                                'email2': currentUser!.email,
                                'username2': currentUser!
                                    .username,
                              });
                        }
                        else {
                          Navigator.pushNamed(
                              context, '/publicOtherProfile',
                              arguments: {
                                'email': mail,
                                'email2': currentUser!.email,
                                'username2': currentUser!.username,
                              });
                        }

                        print('button clicked');
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    username + " - " + petName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    else {
      return Center(
        child: Text('No User Found...'),
      );
    }
  }
}





/*
return Card(
    child: Text(username,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontSize: 20.0,
      ),
    ),
  );

String selectedTerm ="";
List<SearchResult> userResults = [];
List<SearchResult> postResults = [];
user? currentUser;
class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);


  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const historyLength = 5;
  var results = [];
  List<String> _searchHistory = [];
  SharedPreferences? prefs;

  List<String> filteredSearchHistory = [];

  // Number of term

  final _formKey = GlobalKey<FormState>();

  List<String> filteredSearchTerms({
    required String filter,
  }) {

    // Filtering among search history to make search easy
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((element) => element.startsWith(filter))
          .toList();
    } else {
      // if nothing written we can return all search history
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String element) {
    // What we want to do is if the added search term is already exist
    // We dont need to duplicate it
    if (_searchHistory.contains(element)) {
      putSearchTermFirst(element);
      return;
    } else {
      // if element is not exist
      // you may add normally
      _searchHistory.add(element);
      if (_searchHistory.length > historyLength) {
        // remove oldest search until length is proper to add new one
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }
      filteredSearchHistory = filteredSearchTerms(filter: "");
    }
    prefs!.setStringList("search_history", _searchHistory);
  }

  void deleteSearchTerm(String element) {
    _searchHistory.removeWhere((willDelete) => willDelete == element);
    filteredSearchHistory = filteredSearchTerms(filter: "");
  }

  void putSearchTermFirst(element) {
    // if element is already exist will be deleted
    deleteSearchTerm(element);

    // add to the first
    addSearchTerm(element);
  }

  FloatingSearchBarController? controller;

  @override
  void initState() {
    super.initState();
    loadSearchHistory();
    // We are displaying this variable in screen and
    // we need to be sure it is filtered from scratch
    controller = FloatingSearchBarController();
  }

  void loadSearchHistory() async {
    prefs = await SharedPreferences.getInstance();
    var _sh = prefs!.getStringList("search_history");
    if (_sh == null) {
      prefs!.setStringList("search_history", []);
    } else {
      // safe to get
      _searchHistory = _sh;
    }
  }

  void saveHistory() {
    prefs!.setStringList("search_history", _searchHistory);
  }

  @override
  void dispose() {
    saveHistory();
    controller!.dispose();
    super.dispose();
  }

  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  void checkIfExist(String src) {
    bool ch = false;
    for (int i = 0; i < results.length; i++) {
      if (src == results[i].identifier ||
          src == results[i].description) ch = true;
    }
    if (ch == false) {
      crashlytics.setCustomKey("search result not found:", src);
    }
  }

  void getSearchResults(query) async {

    var users = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isGreaterThanOrEqualTo: query,

      isLessThan: query.substring(0, query.length - 1) +
          String.fromCharCode(query.codeUnitAt(query.length - 1) + 1),

    )
        .get();
    //.where('activation', isEqualTo: "active")
    users.docs.forEach((doc) => {
      userResults.add(
          SearchResult(identifier: doc['username'],
              description: doc['description'],
              itemID: doc['uid'],
              photoUrl: doc['photoUrl'])

      )
    });

    setState(() {
      selectedTerm = query;
      results = userResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey[800],
          elevation: 0.0,
          title: Text(
            'Search',
            style: TextStyle(
              color: Colors.grey[300],
              fontSize: 24,

              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FloatingSearchBar(
          automaticallyImplyBackButton: false,
          controller: controller,
          body: FloatingSearchBarScrollNotifier(
            child: GetUserName(selectedTerm),
          ),
          // When we close process will be more nice (
          transition: CircularFloatingSearchBarTransition(),
          // search terms shows up in cool way :)
          physics: BouncingScrollPhysics(),
          title: Text(
            'Enter to search',
            style: Theme.of(context).textTheme.headline6,
          ),
          hint: 'Start typing...',
          actions: [
            FloatingSearchBarAction.searchToClear(),
          ],
          onQueryChanged: (query) {
            setState(() {
              filteredSearchHistory = filteredSearchTerms(filter: query);
            });
          },
          onSubmitted: (query) {
            userResults = [];
            postResults = [];
            checkIfExist(query);
            getSearchResults(query);
            addSearchTerm(query);
            controller!.close();
          },
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4,
                child: Builder(builder: (context) {
                  filteredSearchHistory = filteredSearchTerms(filter: "");
                  if (filteredSearchHistory.isEmpty &&
                      controller!.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'No history exist. Start to explore :)',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    // search history not found but user typing something
                    return ListTile(
                      title: Text(controller!.query),
                      leading: const Icon(Icons.search),
                      // for each type we need to add characters to history which is writing...
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller!.query);
                          selectedTerm = controller!.query;
                        });
                        controller!.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map((e) => ListTile(
                        title: Text(
                          e,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: const Icon(Icons.history),
                        trailing: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              deleteSearchTerm(e);
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            putSearchTermFirst(e);
                            selectedTerm = e;
                          });
                          controller!.close();
                        },
                      ))
                          .toList(),
                    );
                  }
                }),
              ),
            );
          },
        ));
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(selectedTerm).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Center(child: Text("Something went wrong"));
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(child: Text("Document does not exist"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Center(child: Text("Full Name: ${data['username']} ${data['petName']}"));
        }

        return Text("loading");
      },
    );
  }
}


class SearchResultsListView extends StatelessWidget {
  final String searchTerm;

  Widget buildSearchResults(
      List<SearchResult> results, BuildContext context, int index) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text(""),
              subtitle: Text(""),
            ),
          ],
        ),
      ),
    );
  }

  const SearchResultsListView({

    required this.searchTerm,
  });

  noResultsFound(context) {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
                "No results found!"
            ),
          ),
          Container(
            width: double.infinity,
          )
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (searchTerm == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'Explore Sinappses!',
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }

    final fsb = FloatingSearchBar.of(context);
    return ListView(
        padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'People',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (userResults == null || userResults.isEmpty) ? noResultsFound(context) : userResults
                .map((element) => SearchResultCard(
              sr: element, itType: "user",
            )).toList(),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Text(
              'Posts',
              style: TextStyle(
                fontFamily: 'BrandonText',
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(),
          Column(
            children: (postResults == null || postResults.isEmpty) ? noResultsFound(context) : postResults
                .map((element) => SearchResultCard(
              sr: element, itType: "post",
            )).toList(),
          ),
        ]);
  }
}

 */
