import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:pet_project/routes/walkthrough.dart';
import 'package:pet_project/utils/colors.dart';
import 'package:pet_project/routes/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pet_project/routes/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:pet_project/routes/homePage.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:pet_project/utils/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_project/routes/homePage.dart';
import 'package:provider/provider.dart';
/*
void main() => runApp(MaterialApp(
  home: Splash(),
  routes: {
    '/walk': (context) => WalkThrough(),
    '/login': (context) => login(),
    '/SignUp': (context) => SignUp(),

  },
));
 */

FirebaseAnalytics analytics = FirebaseAnalytics();
FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);
final Future<FirebaseApp> _initialization = Firebase.initializeApp();
class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();

}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (preferences.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new login(analytics: analytics, observer: observer)));
    } else {
      await preferences.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new WalkThrough()));
    }
  }


  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    );
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyFirebaseApp());
}

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text(
                    'No Firebase Connection ${snapshot.error.toString()}'
                  ),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {//if it is properly connected
            return AppBase();
          }
          return MaterialApp(
              home: Center(
                child: Text(
                  'Connecting to Firebase',
                ),
              )
          );

        },
    );
  }
}



/*
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        home: homePage(analytics: analytics, observer: observer),
        routes: {
          '/login': (context) => login(),
        },
      ),
    );
  }
*/
  class AppBase extends StatelessWidget {
  const AppBase({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      home: Splash(),
      routes: {
        '/WalkThrough': (context) => WalkThrough(),
        '/login': (context) => login(analytics: analytics, observer: observer),
        '/SignUp': (context) => SignUp(),
        '/homePage': (context) => homePage(),
      },
    )
    );

  }
}














