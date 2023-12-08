
import 'package:flutter/material.dart';
import 'package:invtest2/routpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'UI/screens/Home.dart';
import 'UI/screens/login.dart';

SharedPreferences? sharedPref;
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp( InvTest (appRoute: AppRoute()));
}

class InvTest extends StatelessWidget {

  final AppRoute appRoute;

  const InvTest({super.key, required this.appRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //onGenerateRoute:appRoute.generateRoute,
      home: sharedPref?.getString('token')==null?LogIn():Home(),
    );
  }
}

