import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pet_finder/Screens/Authentication/ForgetPassword.dart';
import 'package:pet_finder/Screens/Authentication/Register.dart';
import 'package:pet_finder/ViewModel/Authentication/FaceBookAuthentication.dart';
import 'package:pet_finder/ViewModel/Authentication/GmailAuthentication.dart';
import 'package:pet_finder/ViewModel/Authentication/Emaillogin.dart';
import 'package:pet_finder/Screens/BottomNavigationBar/CustomNavigation.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  bool showpassword = true;
  // ignore: override_on_non_overriding_member
  GmailAuthentication gmailAuthentication = new GmailAuthentication();
  UserLogin loginAuth = new UserLogin();
  FaceBookAuthentcation faceBookAuthentcation = new FaceBookAuthentcation();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromRGBO(0, 0, 70, 1),
              Color.fromRGBO(28, 181, 224, 1),
              Colors.blue,
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.heightMultiplier * 10,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue[100],
                                    blurRadius: 20,
                                    offset: Offset(10, 10))
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextField(
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    email = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: TextField(
                                  obscureText: showpassword,
                                  onChanged: (value) {
                                    password = value;
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              showpassword = !showpassword;
                                            });
                                          },
                                          child: showpassword
                                              ? Icon(Icons.visibility_off)
                                              : Icon(Icons.visibility)),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ForgetPassword());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            loginAuth.emailLogin(email, password, context);
                          },
                          child: Container(
                            height: SizeConfig.heightMultiplier * 5.5,
                            width: SizeConfig.widthMultiplier * 30,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    color: Colors.grey[300],
                                    offset: Offset(5, 5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue[700]),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Register();
                            }));
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "Continue with social media",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  gmailAuthentication
                                      .registerWithGmail()
                                      .then((_) {
                                    Navigator.popAndPushNamed(context, '/home');
                                  });
                                },
                                child: Container(
                                  height: SizeConfig.heightMultiplier * 6.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.red[600]),
                                  child: Center(
                                    child: Text(
                                      "Gmail",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 5,
                            ),
                            Expanded(
                                child: GestureDetector(
                              onTap: () {
                                faceBookAuthentcation
                                    .signInWithFacebook()
                                    .then((_) {
                                  Get.offAll(CustomNavigation());
                                });
                              },
                              child: Container(
                                height: SizeConfig.heightMultiplier * 6.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue[600]),
                                child: Center(
                                  child: Text(
                                    "Facebook",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.heightMultiplier * 10,
                          child: Center(
                              child: Container(
                            child: Text(
                              'Powered by Virtual Soft',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
