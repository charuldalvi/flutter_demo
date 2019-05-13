import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hbb_customer/signup.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Future _login() async {
    http.Response response;

    response =
        await http.post('http://192.168.0.102/Ayurvedic/action.php', body: {
      'c_email': usernameController.text,
      'c_password': passwordController.text,
      'action': 'customer_login',
    });

 //   print(response.body);

    var data = json.decode(response.body);

    if (data['error'] == false) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('c_name', data['c_name']);
      prefs.setString('c_email', data['c_email']);
      prefs.setInt('status', 1);

      Fluttertoast.showToast(
          msg: 'Login successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.green);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardPage()));
    } else {
      Fluttertoast.showToast(
          msg: 'Login failed',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Hbb Customer App',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter username';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter password';
                    }
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                FlatButton(
                  child: Text(
                    'Dont have a account? Sign Up here!!',
                    style: TextStyle(fontSize: 18.0,color: Theme.of(context).accentColor),
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupPage())),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Login'),
        icon: Icon(FontAwesomeIcons.signInAlt),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isExtended: true,
        onPressed: () {
          _login();
        },
      ),
    );
  }
}
