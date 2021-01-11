import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pet_finder/ViewModel/SizeConfig.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String email;
  TextEditingController controller = TextEditingController();
  @override
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
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome",
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
                            height: SizeConfig.heightMultiplier * 6,
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
                                    controller: controller,
                                    decoration: InputDecoration(
                                        hintText: "Enter Your Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier * 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              resetPassword(context);
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 6,
                              width: SizeConfig.widthMultiplier * 40,
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
                                  "Get Code",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void resetPassword(BuildContext context) async {
    if (controller.text.length == 0 || !controller.text.contains("@")) {
      Fluttertoast.showToast(msg: "Enter valid email");
      return;
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text);
    Fluttertoast.showToast(
        msg:
            "Reset password link has sent your mail please use it to change the password.");
    Navigator.pop(context);
  }
}
