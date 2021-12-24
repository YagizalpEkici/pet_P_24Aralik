import 'package:flutter/material.dart';

class gatherings extends StatelessWidget {
  const gatherings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
          //onPressed:() => exit(0),
        ),
        title: Text(
            'Create New Gathering'
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'You Can Generate and Post new Gathering',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}