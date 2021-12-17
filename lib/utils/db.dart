import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class DBService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('SingUpUser');

  Future addUserAutoID(String username, String email, String name, String surname, String password, String repassword,String petname, String biography, String byear, String breed, String sex, String url) async{
    userCollection.add({
      'username': username,
      'email': email,
      'name': name,
      'surname': surname,
      'password': password,
      'repassword': repassword,
      'petname': petname,
      'biography': biography,
      'byear': byear,
      'breed': breed,
      'sex': sex,
      'url': url,
    })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
/*
  Future addUser(String username, String email, String name, String surname, String password, String repassword) async{
    userCollection.doc(token).set({
      'username': username,
      'email': email,
      'name': name,
      'surname': surname,
      'password': password,
      'repassword': repassword,
    })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }
 */


}