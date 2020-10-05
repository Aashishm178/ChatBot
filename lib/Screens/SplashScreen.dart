import 'dart:async';
import 'package:chatbot/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var margin;
  var textSize;
  AnimationController controller;
  Animation offset;
  EdgeInsetsGeometry edgeInsetsGeometry = EdgeInsets.all(15.0);
  EdgeInsetsGeometry marginOne = EdgeInsets.all(0);
  EdgeInsetsGeometry marginTwo = EdgeInsets.all(0);
  EdgeInsetsGeometry marginThree = EdgeInsets.all(0);
  EdgeInsetsGeometry marginFour = EdgeInsets.all(0);
  EdgeInsetsGeometry marginFive = EdgeInsets.all(0);
  EdgeInsetsGeometry marginSix = EdgeInsets.all(0);
  EdgeInsetsGeometry marginSeven = EdgeInsets.all(0);

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                edgeInsetsGeometry = EdgeInsets.all(25.0);
                marginThree = EdgeInsets.only(right: margin);
                marginTwo = EdgeInsets.only(right: margin * 2);
                marginOne = EdgeInsets.only(right: margin * 3);
                marginFive = EdgeInsets.only(left: margin);
                marginSix = EdgeInsets.only(left: margin * 2);
                marginSeven = EdgeInsets.only(left: margin * 3);
              });
            }
          });
    offset = Tween<Offset>(begin: Offset(0, -5.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    Timer(Duration(milliseconds: 2000), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    margin = (MediaQuery.of(context).size.width / 4) - 10;
    textSize = (MediaQuery.of(context).size.height / 100) * 3;
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SlideTransition(
          position: offset,
          child: RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(controller),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'C',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginOne,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'H',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginTwo,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'A',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginThree,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'T',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginFour,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'B',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginFive,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'O',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginSix,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'T',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: textSize),
                  ),
                  padding: edgeInsetsGeometry,
                  margin: marginSeven,
                  decoration: BoxDecoration(
                      color: Colors.black, shape: BoxShape.circle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
