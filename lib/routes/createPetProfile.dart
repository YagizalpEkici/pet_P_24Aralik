import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file/file.dart';
import 'package:pet_project/utils/db.dart';

class createPet extends StatefulWidget{
  @override
  _createPet createState() => _createPet();
}

class _createPet extends State<createPet> {
  final _formKey = GlobalKey<FormState>();
  String petName = "";
  String bio = "";
  String birthYear = "";
  String breed = "";
  String sex = "";
  List<String> sexType = ["female", "male", "none"];

  final ImagePicker _picker = ImagePicker();
  String url ="";
  DBService db = DBService();

  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        url = image.path;
      });
    }
  }

  _imgFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        url = image.path;
      });
    }
  }

  @override
  void initState(){
    super.initState();
  }

  void buttonPressed() {
    print(petName+"\n"+bio+"\n"+birthYear+"\n"+breed+"\n"+sex+"\n");
  }
  void pageDirection() {
    Navigator.pushNamed(context, '/homePage');
  }
  void textPressed() {}

  @override
  Widget build (BuildContext context){
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
        body: SafeArea(
            child : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child:
                                      Image.network(url),
                                  ),
                                  radius: 60,
                                ),
                              ),
                            ]
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Column(
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                  (Set<MaterialState> states) {
                                                if(states.contains(MaterialState.pressed))
                                                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                                return Colors.blueGrey;
                                              }
                                          ),
                                        ),
                                        onPressed: (){
                                          //chooseImage();
                                          _imgFromGallery();
                                        },
                                        child: Text('Add Profile Picture',
                                          style: TextStyle(fontSize: 15, color: Colors.white,),),

                                      ),
                                    ]
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "Pet's Name",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if(value==null){
                                    return 'Pet name field cannot be empty!';
                                  }
                                  else{
                                    String trimmedValue = value.trim();
                                    if(trimmedValue.isEmpty){
                                      return 'Pet name field cannot be empty';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  if(value != null){
                                    petName = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "Biography",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                onSaved: (value){
                                  if(value != null){
                                    bio = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "Birth Year",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                onSaved: (value){
                                  if(value != null){
                                    birthYear = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.grey,
                                  filled: true,
                                  hintText: "Breed",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                onSaved: (value){
                                  if(value != null){
                                    breed = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height : 10,),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.rectangle,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButton<String>(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  iconEnabledColor: Colors.black,
                                  dropdownColor: Colors.white,
                                  alignment: AlignmentDirectional.center,
                                  icon: Icon(Icons.arrow_drop_down),
                                  hint: Text('Sex'),
                                  underline: SizedBox(),
                                  items: sexType.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if(value != null){
                                      sex = value;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 80,),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                              (Set<MaterialState> states) {
                                            if(states.contains(MaterialState.pressed))
                                              return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                            return Colors.blueGrey;
                                          },
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print("route: homePage successful");
                                          _formKey.currentState!.save();
                                          db.addUserAutoID(args['username'],args['email'],args['name'],args['surname'],args['password'],args['repassword'],petName,bio,birthYear,breed,sex,url);
                                          //_setCurrentScreen();
                                          pageDirection();
                                        }
                                      },
                                      child: Text(
                                        'Enter',
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 80,),
                                  ],
                                ),
                              ]
                          ),
                        ),
                      ]
                  ),
                ),
              ),
            )
        )
    );
  }
}