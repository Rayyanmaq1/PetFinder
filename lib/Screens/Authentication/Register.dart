import 'package:flutter/material.dart';
import 'package:pet_finder/ViewModel/Authentication/signInWithEmail.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password, firstName, secondName;
  EmailSignIn emailSignIn = new EmailSignIn();
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
                height: 80,
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
                            height: 60,
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
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter Your Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                                    onChanged: (value) {
                                      password = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                                    onChanged: (value) {
                                      firstName = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "First Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
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
                                    onChanged: (value) {
                                      secondName = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Second Name",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await emailSignIn.signInWithEmail(
                                  email, password, firstName, secondName);
                              Navigator.popAndPushNamed(context, '/home');
                            },
                            child: Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      color: Colors.blue[200],
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue[700]),
                              child: Center(
                                child: Text(
                                  "Register",
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
}
