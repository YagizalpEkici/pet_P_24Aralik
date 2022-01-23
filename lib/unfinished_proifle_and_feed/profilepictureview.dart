import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePictureView extends StatelessWidget {
  final double minScale = 1;
  final double maxScale = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            maxScale: maxScale,
            minScale: minScale,
            panEnabled: true,
            child: Hero(
              tag: 'imageHero',
              child: Image.network(
                'https://cdn-1.motorsport.com/images/amp/YpN8nVN0/s1000/sergio-perez-red-bull-racing-1.jpg',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
