import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Screentwo extends StatelessWidget {
  final String? message;

  Screentwo( {this.message});

  @override
  Widget build(BuildContext context) {
    if (message == "Invalid Credentials") {
      // Show an error message or perform other actions as needed
      return Scaffold(
        body: Center(
          child: Text("Invalid Credentials. Please try again."),
        ),
      );
    } else {
      // Continue with the success screen
      return Scaffold(
        body: Center(
          child: Text("Success Screen"),
        ),
      );
    }
  }
}

