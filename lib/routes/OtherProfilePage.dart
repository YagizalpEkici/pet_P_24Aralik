import 'package:flutter/material.dart';
import 'package:pet_project/firestore_related/users.dart';

class OtherProfilePag extends StatelessWidget {
  const OtherProfilePag ({Key? key,required this.otherUser}) : super(key: key);

  final user otherUser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Other Profile Page',
      style: TextStyle(
        fontSize: 50,
      ),),
    );
  }
}
