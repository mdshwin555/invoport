import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:invtest2/constance/mycolor.dart';
import '../../constance/api.dart';
import '../../constance/routes.dart';
import '../../main.dart';

abstract class SignInController extends GetxController {
  signIn(BuildContext context);
}

class SignInControllerImp extends SignInController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController accountController;
  GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  late BuildContext context;
  RxBool obscureText = true.obs;

  void updateObscure() {
    obscureText.value = !obscureText.value;
    update();
  }
  bool validateFields() {
    return accountController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }


  @override
  signIn(context) async {
    if (validateFields()) {
      var client = http.Client();
      var url = Uri.parse(ApiLink.Login);
      var response = await client.post(
        url,
        body: {
          'password': passwordController.text,
          'email': emailController.text,
          'account': accountController.text,
        },
      );
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['massage'] == 'Login successfully') {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.infoReverse,
          animType: AnimType.bottomSlide,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: [
                Text(
                  "Do you want to save your \n information ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Rubik",
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        sharedPref?.setString('token', 'true');
                        Get.offNamed(AppRoute.home);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Set the background color for "OK" button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('OK'),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoute.home);
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ).show();

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['massage']),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    accountController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    accountController.dispose();
    super.dispose();
  }
}
