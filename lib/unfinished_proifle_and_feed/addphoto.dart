import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_project/routes/homePage.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';



class addphoto extends StatefulWidget {
  const addphoto({Key? key}) : super(key: key);

  @override
  _addphotoState createState() => _addphotoState();
}

class _addphotoState extends State<addphoto> {

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future pickImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Photo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: ClipRRect(
                              //clipper: ,
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                child: getImage(),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ]
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if(states.contains(MaterialState.pressed))
                      return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    return Colors.grey;
                  },
                ),
              ),
              onPressed: pickImageGallery,
              child: Text(
                'Upload a photo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            decoration: InputDecoration(
                              fillColor: AppColors.app_icons,
                              filled: true,
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.text_color,
                                ),
                                borderRadius: Dimen.Border,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Post')),
          ],
        ),
      ),
    );
  }

  Widget getImage() {
    return _image != null ? Image.file(File(_image!.path)) :TextButton(
      child:
      Icon(
          Icons.add,
          color: Colors.blue,
          size:200
      ),
      onPressed: () {},
    );
  }

}
