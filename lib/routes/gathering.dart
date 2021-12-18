import 'package:flutter/material.dart';

class gathering extends StatelessWidget {
  const gathering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'gathering page',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}