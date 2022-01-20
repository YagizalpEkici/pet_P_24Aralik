import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String comment;
  String Commentemail;
  String cid;
  String pid;
  String Commentusername;


  Comments(
      {required this.comment,
        required this.Commentemail,
        required this.cid,
        required this.pid,
        required this.Commentusername,
      });

  Comments.fromData(Map<String, dynamic> data)
      : comment = data['comment'],
        Commentemail = data['Commentemail'],
        cid = data['cid'],
        pid = data['pid'],
        Commentusername = data['Commentusername'];


  factory Comments.fromDocument(DocumentSnapshot doc) {
    return Comments(
      comment: doc['comment'],
      Commentemail: doc['Commentemail'],
      cid: doc['cid'],
      pid: doc['pid'],
      Commentusername: doc['Commentusername']
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'Commentemail': Commentemail,
      'cid': cid,
      'pid': pid,
      'Commentusername' : Commentusername,
    };
  }
}