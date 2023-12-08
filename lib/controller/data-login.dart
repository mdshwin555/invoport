import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/model-login.dart';
class UserController {
  Future<LoginResponse> loginUser(String password, String email, String account) async {
    var client = http.Client();
    var url = Uri.parse('https://dev.invoport.lu/api/api-Login.php');


      var response = await client.post(
        url,
        body: {
          'password': password,
          'email': email,
          'account': account,
        },
      );

    var jsonResponse = json.decode(response.body);
    print(jsonResponse['massage']);
    return LoginResponse.fromJson(jsonResponse);
  }
}
