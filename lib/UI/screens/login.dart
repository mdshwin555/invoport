import 'package:flutter/material.dart';
import '../../Model/model-login.dart';
import '../../constance/mycolor.dart';
import '../../controller/data-login.dart';
import '../../main.dart';
import '../widgets/leadin.dart';
import 'Home.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final accountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserController userController=UserController();

  bool _validateFields() {
    if (accountController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }


  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Leading(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 20),
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                  child: Image.asset(
                    "images/Logo with no background.png",
                    width: MediaQuery.of(context).size.width * 0.6,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Rubik",
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                      ),
                    ),
                    Image.asset(
                      "images/img.png",
                      width: MediaQuery.of(context).size.width * 0.05,
                      height: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 5),
                child: Text(
                  "Log In Invoport",
                  style: TextStyle(
                    color: MyColor.greydark,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Rubik",
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Account", Icons.person),
                    _buildTextFieldEmail("Email", Icons.attach_email),
                    _buildPasswordField("Password", Icons.playlist_add_check_sharp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 10),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (_validateFields()) {
                            try {
                              final response = await userController.loginUser(
                                passwordController.text,
                                emailController.text,
                                accountController.text,
                              );

                              if (response.message == 'Login successfully') {
                                // Show dialog on successful login
                                await  showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Login Successful'),
                                      content: Text('Do you want to save your information ?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Save token to SharedPreferences
                                            // Replace 'yourToken' with the actual token value
                                            sharedPref?.setString('token', 'true');

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home()
                                              ),
                                            );
                                          },
                                          child: Text('OK'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Home()
                                              ),
                                            );
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );


                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Login failed'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login failed'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff03A8EA),
                          minimumSize: Size(double.infinity, MediaQuery.of(context).size.height * 0.07),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                          ),
                        ),
                        icon: Image.asset("images/img_2.png", width: 20, height: 20),
                        label: Text("Log In", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you need any help? ",
                          style: TextStyle(
                            color: MyColor.greydark,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Rubik",
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                        Text(
                          "Connect with us",
                          style: TextStyle(
                            color: Color(0xff379C42),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Rubik",
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                        Icon(Icons.add_call, color: Color(0xff379C42), size: MediaQuery.of(context).size.width * 0.035),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Text(
            label,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.075,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: MediaQuery.of(context).size.width * 0.002,
                  blurRadius: MediaQuery.of(context).size.width * 0.005,
                  offset: Offset(0, MediaQuery.of(context).size.width * 0.015),
                ),
              ],
            ),
            child: TextFormField(
              controller: accountController,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Your $label",
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: MediaQuery.of(context).size.width * 0.028),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Icon(icon, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildTextFieldEmail(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Text(
            label,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.075,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: MediaQuery.of(context).size.width * 0.002,
                  blurRadius: MediaQuery.of(context).size.width * 0.005,
                  offset: Offset(0, MediaQuery.of(context).size.width * 0.015),
                ),
              ],
            ),
            child: TextFormField(
              controller: emailController,
              obscureText: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Your $label",
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: MediaQuery.of(context).size.width * 0.028),
                border: InputBorder.none,
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Icon(icon, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPasswordField(String label, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Text(
            label,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: 10),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.075,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: MediaQuery.of(context).size.width * 0.002,
                  blurRadius: MediaQuery.of(context).size.width * 0.005,
                  offset: Offset(0, MediaQuery.of(context).size.width * 0.015),
                ),
              ],
            ),
            child: TextFormField(
              controller: passwordController,
              obscureText: _obscureText,
              validator: (value) {
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Enter Strong $label",
                hintStyle: TextStyle(color: Colors.blueGrey, fontSize: MediaQuery.of(context).size.width * 0.028),
                border: InputBorder.none,
                suffixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                  ),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02),
                  child: Icon(icon, color: Colors.blue),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
