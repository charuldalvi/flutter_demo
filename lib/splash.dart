import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth.dart';
import 'dashboard.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {
  int status = 0;

  Future<int> checkStatus(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    status = sharedPreferences.getInt('status');
    if (status == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AuthPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardPage()));
    }
    return status;
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 3000), () => checkStatus(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                'Hbb Customer',
                style: TextStyle(
                    fontSize: 30.0, color: Theme.of(context).primaryColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
