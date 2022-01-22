import 'package:cloud_firestore/cloud_firestore.dart';

class forum {
  String header;
  String description;
  int like;
  String fid;
  String username;
  String photo;
  String usermail;


  forum(
      {required this.header,
        required this.description,
        required this.like,
        required this.fid,
        required this.username,
        required this.usermail,
        required this.photo,

      });

  forum.fromData(Map<String, dynamic> data)
      : header = data['header'],
        description = data['description'],
        like = data['like'],
        fid = data['fid'],
        username = data['username'],
        photo = data['photo'],
        usermail = data['usermail'];


  factory forum.fromDocument(DocumentSnapshot doc) {
    return forum(
      header: doc['header'],
      description: doc['description'],
      like: doc['like'],
      fid: doc['fid'],
      username: doc['username'],
      photo: doc['photo'],
      usermail: doc['usermail'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'description': description,
      'like': like,
      'fid': fid,
      'username': username,
      'photo': photo,
      'usermail' :usermail
    };
  }
}