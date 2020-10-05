import 'dart:async';
import 'package:chatbot/Utiils/Authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController username;
  TextEditingController password;
  TextEditingController reEnterPassword;
  bool loading;
  Authenticate authenticate;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    reEnterPassword = TextEditingController();
    loading = false;
    authenticate = Authenticate();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
    reEnterPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: 'signup',
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Email Address';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return 'Enter valid email';
                        } else {
                          return null;
                        }
                      },
                      controller: username,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: 'Email Address',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Password';
                        } else if (value.length < 8) {
                          return 'Minimum Password length is 8 characters';
                        } else {
                          return null;
                        }
                      },
                      controller: password,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Reenter Password';
                        } else if (value != password.text) {
                          return 'Password do not match';
                        } else {
                          return null;
                        }
                      },
                      controller: reEnterPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.grey)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.black)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.black),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                child: loading
                    ? Material(
                        elevation: 2.0,
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        ),
                      )
                    : RaisedButton(
                        color: Colors.black,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            FocusScope.of(context).requestFocus(FocusNode());
                            try {
                              var result =
                                  await authenticate.addUserEmailAndPassword(
                                      username.text, password.text);
                              setState(() {
                                loading = false;
                              });
                              if (result) {
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                SnackBar snack = SnackBar(
                                  elevation: 6.0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('USER SIGNED UP SUCCESSFULLY'),
                                  duration: Duration(seconds: 2),
                                );
                                scaffoldKey.currentState.showSnackBar(snack);
                                Timer(Duration(seconds: 2), () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false);
                                });
                              } else {
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                SnackBar snack = SnackBar(
                                  action: SnackBarAction(
                                      textColor: Colors.purpleAccent,
                                      label: 'OK',
                                      onPressed: () {}),
                                  elevation: 6.0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('SIGNUP FAILED'),
                                  duration: Duration(seconds: 4),
                                );
                                scaffoldKey.currentState.showSnackBar(snack);
                              }
                            } catch (error) {
                              setState(() {
                                loading = false;
                              });
                              if (error
                                  .toString()
                                  .toLowerCase()
                                  .contains('invalid_email')) {
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                SnackBar snack = SnackBar(
                                  action: SnackBarAction(
                                      textColor: Colors.purpleAccent,
                                      label: 'OK',
                                      onPressed: () {}),
                                  elevation: 6.0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('INVALID EMAIL ID'),
                                  duration: Duration(seconds: 4),
                                );
                                scaffoldKey.currentState.showSnackBar(snack);
                              } else if (error
                                      .toString()
                                      .toLowerCase()
                                      .contains('email_already_in_use') ||
                                  error
                                      .toString()
                                      .toLowerCase()
                                      .contains('uid_already_exists')) {
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                SnackBar snack = SnackBar(
                                  action: SnackBarAction(
                                      textColor: Colors.purpleAccent,
                                      label: 'OK',
                                      onPressed: () {}),
                                  elevation: 6.0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('USERNAME ALREADY EXIST'),
                                  duration: Duration(seconds: 4),
                                );
                                scaffoldKey.currentState.showSnackBar(snack);
                              } else {
                                scaffoldKey.currentState.hideCurrentSnackBar();
                                SnackBar snack = SnackBar(
                                  action: SnackBarAction(
                                      textColor: Colors.purpleAccent,
                                      label: 'OK',
                                      onPressed: () {}),
                                  elevation: 6.0,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text('PLEASE TRY AGAIN'),
                                  duration: Duration(seconds: 4),
                                );
                                scaffoldKey.currentState.showSnackBar(snack);
                              }
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
              ),
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
