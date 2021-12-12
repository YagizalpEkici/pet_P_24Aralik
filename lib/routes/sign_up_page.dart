import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:pet_project/routes/sign_up_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:pet_project/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
//flutter run --no-sound-null-safety
class SignUp extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp>{
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String email = "";
  String surname = "";
  String username = "";
  String password = "";
  String repassword = "";
  AuthService auth = AuthService();
  TextEditingController pass = TextEditingController();
  TextEditingController repass = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  bool check(String password, String repassword) {
    if(repassword != password) {
      return false;
    }
    return true;
  }

  void buttonPressed() {
    print(username + " " + name + " " + surname + " " + email + " " + password + " " + repassword);
  }
  void textPressed(){
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child : SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: ClipOval(
                              child:
                              Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                            ),
                            radius: 60,
                          ),
                        ),
                      ],
                    ),
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
                          hintText: "Username",
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
                            return 'username field cannot be empty!';
                          }
                          else{
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty){
                              return 'username field cannot be empty';
                            }
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            username = value;
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
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value==null){
                            return 'email field cannot be empty!';
                          }
                          else{

                            if(value.isEmpty){
                              return 'email field cannot be empty';
                            }
                            if(!EmailValidator.validate(value)){
                              return 'please enter a valid email!';
                            }
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            email = value;
                          }
                        },

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          hintText: "Name",
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
                            return 'name field cannot be empty!';
                          }
                          else{

                            if(value.isEmpty){
                              return 'name field cannot be empty';
                            }
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            name = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height : 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          hintText: "Surname",
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
                            return 'surname field cannot be empty!';
                          }
                          else{

                            if(value.isEmpty){
                              return 'surname field cannot be empty';
                            }
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            surname = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: pass,
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if(value == null){
                            return 'password field cannot be empty!';
                          }
                          if(pass.text.length == 0)
                          {
                            return 'password field cannot be empty!';
                          }
                          if(pass.text.length < 8)
                          {
                            return 'password has to be at least 8 characters long!';
                          }
                          return null;
                        },

                        obscureText: true,
                        onSaved: (value) {
                          if (value != null) {
                            password = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: repass,
                        decoration: InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          hintText: "Re-type password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        validator: (value) {
                          if(value==null){
                            return 'password field cannot be empty!';
                          }
                          if(repass.text.length == 0)
                          {
                            return 'password field cannot be empty!';
                          }
                          if(repass.text.length < 8)
                          {
                            return 'password has to be at least 8 characters long!';
                          }
                          if(pass.text != repass.text){
                            return "Password does not match";
                          }
                          return null;
                        },
                        onSaved: (value){
                          if(value != null){
                            repassword = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://i.ebayimg.com/images/g/WIgAAOSwal5YIJHv/s-l300.jpg",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
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
                              if(_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                buttonPressed();
                              }
                              auth.signupWithMailAndPass(email, password);

                            },
                            child: Text(
                              'Sign-up',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 80,),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Divider(thickness: 2,color: Colors.black,),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: textPressed,
                            child: Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.deepOrangeAccent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

