import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UI/screens/login.dart';
import 'UI/screens/screen1.dart';


class AppRoute{
Route ?generateRoute(RouteSettings settings){
  switch(settings.name){
    case'/':
      return MaterialPageRoute(builder: (_)=>ScreenOne());
    case'Log':
      return MaterialPageRoute(builder: (_)=>LogIn());
  }
}
}