import 'package:get/get.dart';
import 'package:invtest2/UI/screens/Home.dart';
import 'package:invtest2/UI/screens/login.dart';
import 'constance/routes.dart';

List<GetPage<dynamic>>? routes = [
  // Auth
  GetPage(name: AppRoute.signIn, page: () => const LogIn()),

  // Home
  GetPage(name: AppRoute.home, page: () =>  Home()),
];
