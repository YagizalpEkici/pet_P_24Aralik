import 'package:cloud_firestore/cloud_firestore.dart';

class user {
  String username;
  String name;
  String surname;
  String password;
  String photoUrl;
  String email;
  String breed;
  String sex;
  String birthYear;
  String petName;
  List<dynamic> followers;
  List<dynamic> following;
  List<dynamic> posts;
  String bio;
  bool profType;

  user(
      {required this.username,
        required this.name,
        required this.password,
        required this.breed,
        required this.sex,
        required this.petName,
        required this.birthYear,
        required this.surname,
        required this.followers,
        required this.following,
        required this.posts,
        required this.bio,
        required this.photoUrl,
        required this.email,
        required this.profType,
        });

  user.fromData(Map<String, dynamic> data)
      : username = data['username'],
        name = data['name'],
        breed = data['breed'],
        petName = data['petName'],
        birthYear = data['birthYear'],
        sex = data['sex'],
        surname = data['surname'],
        password = data['password'],
        followers = data['followers'],
        following = data['following'],
        posts = data['posts'],
        bio = data['bio'],
        photoUrl = data['photoUrl'],
        email = data['email'],
        profType = data['profType'];

  factory user.fromDocument(DocumentSnapshot doc) {
    return user(
      username: doc['username'],
      name: doc['name'],
      breed: doc['breed'],
      sex: doc['sex'],
      birthYear: doc['birthYear'],
      petName: doc['petName'],
      surname: doc['surname'],
      password: doc['password'],
      followers: doc['followers'],
      following: doc['following'],
      posts: doc['posts'],
      bio: doc['bio'],
      photoUrl: doc['photoUrl'],
      email: doc['email'],
      profType: doc['profType'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'breed': breed,
      'petName': petName,
      'sex': sex,
      'birthYear': birthYear,
      'password': password,
      'surname': surname,
      'followers': followers,
      'following': following,
      'posts': posts,
      'bio': bio,
      'photoUrl': photoUrl,
      'email': email,
      'profType': profType,
    };
  }

}