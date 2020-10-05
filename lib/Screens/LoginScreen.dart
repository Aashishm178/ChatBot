import 'package:chatbot/Screens/ChatListScreen.dart';
import 'package:chatbot/Screens/SignUpScreen.dart';
import 'package:chatbot/Utiils/Authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username;
  TextEditingController password;
  bool obscure = true;
  Authenticate authenticate;
  Color eyeColor;
  BuildContext _dismissContext;

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    authenticate = Authenticate();
    eyeColor = Colors.grey;
  }

  @override
  void didChangeDependencies() {
    _dismissContext = context;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
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
                              return 'Enter valid Email';
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
                          obscureText: obscure,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Enter password';
                            } else if (value.length < 8) {
                              return 'Enter password with min. 8 characters';
                            } else {
                              return null;
                            }
                          },
                          controller: password,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                color: eyeColor,
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  if (obscure) {
                                    setState(() {
                                      obscure = false;
                                      eyeColor = Colors.blue;
                                    });
                                  } else {
                                    setState(() {
                                      obscure = true;
                                      eyeColor = Colors.grey;
                                    });
                                  }
                                }),
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
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              child: RaisedButton(
                color: Colors.black,
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    try {
                      showDialog(
                          barrierDismissible: false,
                          context: _dismissContext,
                          builder: (_) {
                            return AlertDialog(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircularProgressIndicator(),
                                  Container(
                                    margin: EdgeInsets.only(left: 40.0),
                                    child: Text(
                                      'Authenticating.....',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                      var result = await authenticate.authenticateFirebaseUser(
                          username.text, password.text);
                      Navigator.of(_dismissContext).pop();
                      if (result['success'] == true) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => ChatListScreen(
                                      firebaseUser: result['User'],
                                    )),
                            (Route<dynamic> route) => false);
                      } else {
                        scaffoldKey.currentState.hideCurrentSnackBar();
                        SnackBar snack = SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.purpleAccent,
                              label: 'OK',
                              onPressed: () {}),
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: Text('LOGIN FAILED'),
                          duration: Duration(seconds: 4),
                        );
                        scaffoldKey.currentState.showSnackBar(snack);
                      }
                    } catch (error) {
                      Navigator.of(_dismissContext).pop();
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
                          .contains('invalid_password')) {
                        scaffoldKey.currentState.hideCurrentSnackBar();
                        SnackBar snack = SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.purpleAccent,
                              label: 'OK',
                              onPressed: () {}),
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: Text('INVALID PASSWORD'),
                          duration: Duration(seconds: 4),
                        );
                        scaffoldKey.currentState.showSnackBar(snack);
                      } else if (error
                          .toString()
                          .toLowerCase()
                          .contains('user_not_found')) {
                        scaffoldKey.currentState.hideCurrentSnackBar();
                        SnackBar snack = SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.purpleAccent,
                              label: 'OK',
                              onPressed: () {}),
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: Text('USER DO NOT FOUND'),
                          duration: Duration(seconds: 4),
                        );
                        scaffoldKey.currentState.showSnackBar(snack);
                      } else if (error
                          .toString()
                          .toLowerCase()
                          .contains('wrong_password')) {
                        scaffoldKey.currentState.hideCurrentSnackBar();
                        SnackBar snack = SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.purpleAccent,
                              label: 'OK',
                              onPressed: () {}),
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: Text('INCORRECT PASSWORD'),
                          duration: Duration(seconds: 4),
                        );
                        scaffoldKey.currentState.showSnackBar(snack);
                      } else if (error
                          .toString()
                          .toLowerCase()
                          .contains('user_disabled')) {
                        scaffoldKey.currentState.hideCurrentSnackBar();
                        SnackBar snack = SnackBar(
                          action: SnackBarAction(
                              textColor: Colors.purpleAccent,
                              label: 'OK',
                              onPressed: () {}),
                          elevation: 6.0,
                          behavior: SnackBarBehavior.floating,
                          content: Text('USER DISABLED'),
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
                  padding: EdgeInsets.all(15.0),
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
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Or login with',
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        try {
                          showDialog(
                              barrierDismissible: false,
                              context: _dismissContext,
                              builder: (_) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircularProgressIndicator(),
                                      Container(
                                        margin: EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          'Authenticating.....',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                          var result = await authenticate.gmailLogin();
                          Navigator.of(_dismissContext).pop();
                          if (result['success'] == true) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ChatListScreen(
                                          firebaseUser: result['User'],
                                        )),
                                (Route<dynamic> route) => false);
                          } else {
                            scaffoldKey.currentState.hideCurrentSnackBar();
                            SnackBar snack = SnackBar(
                              action: SnackBarAction(
                                  textColor: Colors.purpleAccent,
                                  label: 'OK',
                                  onPressed: () {}),
                              elevation: 6.0,
                              behavior: SnackBarBehavior.floating,
                              content: Text('LOGIN FAILED'),
                              duration: Duration(seconds: 4),
                            );
                            scaffoldKey.currentState.showSnackBar(snack);
                          }
                          print(result);
                        } catch (error) {
                          Navigator.of(_dismissContext).pop();
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
                          print(error);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          maxRadius: 25.0,
                          minRadius: 15.0,
                          backgroundImage:
                              AssetImage('assets/images/google.png'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          showDialog(
                              barrierDismissible: false,
                              context: _dismissContext,
                              builder: (_) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircularProgressIndicator(),
                                      Container(
                                        margin: EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          'Authenticating.....',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                          var result = await authenticate.facebookLogin();
                          Navigator.of(_dismissContext).pop();
                          if (result['success'] == true) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ChatListScreen(
                                          firebaseUser: result['User'],
                                        )),
                                (Route<dynamic> route) => false);
                          } else {
                            scaffoldKey.currentState.hideCurrentSnackBar();
                            SnackBar snack = SnackBar(
                              action: SnackBarAction(
                                  textColor: Colors.purpleAccent,
                                  label: 'OK',
                                  onPressed: () {}),
                              elevation: 6.0,
                              behavior: SnackBarBehavior.floating,
                              content: Text('LOGIN FAILED'),
                              duration: Duration(seconds: 4),
                            );
                            scaffoldKey.currentState.showSnackBar(snack);
                          }
                        } catch (error) {
                          Navigator.of(_dismissContext).pop();
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
                          print(error);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          maxRadius: 25.0,
                          minRadius: 15.0,
                          backgroundImage:
                              AssetImage('assets/images/facebook.png'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          showDialog(
                              barrierDismissible: false,
                              context: _dismissContext,
                              builder: (_) {
                                return AlertDialog(
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CircularProgressIndicator(),
                                      Container(
                                        margin: EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          'Authenticating.....',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                          var result = await authenticate.twitterLogin();
                          Navigator.of(_dismissContext).pop();
                          if (result['success'] == true) {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => ChatListScreen(
                                          firebaseUser: result['User'],
                                        )),
                                (Route<dynamic> route) => false);
                          } else {
                            scaffoldKey.currentState.hideCurrentSnackBar();
                            SnackBar snack = SnackBar(
                              action: SnackBarAction(
                                  textColor: Colors.purpleAccent,
                                  label: 'OK',
                                  onPressed: () {}),
                              elevation: 6.0,
                              behavior: SnackBarBehavior.floating,
                              content: Text('LOGIN FAILED'),
                              duration: Duration(seconds: 4),
                            );
                            scaffoldKey.currentState.showSnackBar(snack);
                          }
                        } catch (error) {
                          Navigator.of(_dismissContext).pop();
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
                          print(error);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        child: CircleAvatar(
                          maxRadius: 25.0,
                          minRadius: 15.0,
                          backgroundImage:
                              AssetImage('assets/images/twitter.png'),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You Don\'t have an account ?',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: Hero(
                          tag: 'signup',
                          child: Text(' SIGN UP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
