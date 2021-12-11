
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/utils/dimensions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';


class login extends StatefulWidget {
  ///////////////////////////////////////////// down side is analytics
  const login({Key? key, required this.analytics, required this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _loginState createState () => _loginState();
}

class _loginState extends State<login> {

  String _message = '';
  void setMessage(String msg){
  setState(() {
  _message = msg;
  });
  }

  Future <void> _setCurrentScreen() async
  {
    await widget.analytics.setCurrentScreen(screenName: 'login page');
    setMessage('setCurrentScreen succeded');
  }

  Future <void> _setLogEvent() async
  {
    await widget.analytics.logEvent(
        name: 'pet_project_test',
        parameters: <String, dynamic>{
          'string': 'string',
          'int': 310,
          'long': 12231412,
          'double': 310.5,
          'bool': true,
        }
    );
    setMessage('CustomLog succeded');
  }


  /////////////////////////////////////// upside for analytics. rest is previous login things.

  final _formKey = GlobalKey<FormState>();
  String name ="";
  String pass = "";
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  void buttonPressed() {
    print(name);
    print(pass);
  }

  void pagedirection() {
    Navigator.pushNamed(context, '/SignUp');
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Dimen.RegularPadding,
        child: SingleChildScrollView(
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
                          padding: Dimen.RegularPadding,
                          child: CircleAvatar(
                            child: ClipOval(
                              child:
                              Image.network('https://cdn2.iconfinder.com/data/icons/veterinary-12/512/Veterinary_Icons-16-512.png'),
                            ),
                            radius: 60,
                          ),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: Dimen.Border,
                          ),
                        ),
                        keyboardType: TextInputType.text,

                        validator: (value) {
                          if(value == null) {
                            return 'Name field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Name field cannot be empty';
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if(value != null) {
                            name = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.app_icons,
                          filled: true,
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.text_color,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,

                        validator: (value) {
                          if(value == null) {
                            return 'Password field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                          }
                          return null;
                        },

                        onSaved: (value) {
                          if(value != null) {
                            pass = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: Dimen.RegularPadding,
                      child: Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text_color,
                        ),
                      ),
                    ),
                    Checkbox(
                      checkColor: AppColors.Background,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    IconButton(onPressed: buttonPressed,
                      icon: FaIcon(FontAwesomeIcons.facebook),),
                    SizedBox(width: 5,),
                    IconButton(onPressed: buttonPressed,
                      icon: FaIcon(FontAwesomeIcons.google),),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://i.ebayimg.com/images/g/WIgAAOSwal5YIJHv/s-l300.jpg",
                      ),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 200,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 80,),
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed))
                                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                                  return AppColors.login_button_Color; // Use the component's default.
                                },
                              ),
                            ),
                            onPressed: () {
                              if(_formKey.currentState!.validate()) {
                                print('Name: '+name+"\nPass: "+pass);
                                _formKey.currentState!.save();
                                _setCurrentScreen();

                              }
                            },
                            child: Text(
                              'login',
                              style:TextStyle(
                                fontSize: 30,
                                color: AppColors.Background,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: _setLogEvent,
                              child: const Text('Custom log event'),
                          ),
                          SizedBox(width: 80),
                        ],
                      ),
                      SizedBox(height: 10,),

                      Divider(thickness: 2,color: AppColors.text_color,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.text_color,
                            ),
                          ),
                          TextButton(
                            onPressed: pagedirection,
                            child: Text(
                              'Sign up now',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.login_page_signup,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      )
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