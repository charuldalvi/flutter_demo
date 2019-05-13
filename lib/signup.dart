import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hbb_customer/auth.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController address = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

Future signup() async {

 http.Response response;

 final Map<String, dynamic> customerData = {
   'c_name': name.text,
    'c_email': email.text,
    'c_password': password.text,
    'c_mobile' : mobile.text,
    'c_address' : address.text,
    'action' : 'customer_registration'
 };

 response = await http.post('http://192.168.0.102/Ayurvedic/action.php', body: json.encode(customerData));

 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthPage()));

}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 600.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: new Color(0xFF622f48),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black87,
                            offset: Offset.zero,
                            blurRadius: 10.0,
                            spreadRadius: 2.0)
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.0),
                          topRight: Radius.circular(0.0))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: name,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter name';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: email,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.orange),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter Email Id';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: password,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.orange),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
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
                          TextFormField(
                            controller: mobile,
                            style: TextStyle(color: Colors.white),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white),
                              labelText: 'Mobile',
                              labelStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(color: Colors.orange),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(),
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter Mobile num';
                              }
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: address,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                labelText: 'Address',
                                labelStyle: TextStyle(color: Colors.white),
                                errorStyle: TextStyle(color: Colors.orange),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter Address';
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                height: 55.0,
                width: 180.0,
                child: MaterialButton(
                  onPressed: () => signup(),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300),
                  ),
                  color: Colors.orange,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(color: Colors.transparent)),
                  elevation: 4.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
