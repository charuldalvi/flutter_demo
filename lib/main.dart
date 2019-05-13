
import 'package:flutter/material.dart';
import 'auth.dart';
import 'splash.dart';

void main(){
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Hbb Customer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purpleAccent,
        
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.pink,
      )
      ),
      home: SplashPage(),
    );
  }
}