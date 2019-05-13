import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hbb_customer/auth.dart';
import 'package:hbb_customer/bookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => new _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _name;

  getSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("c_name");
    return _name;
  }

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }
  
  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('status',null);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AuthPage()));
  }

  

  Material MyItems(IconData icon, String heading, int color, int index) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      shadowColor: Colors.black26,
      elevation: 4.0,
      child: GestureDetector(
        onTap: () {
          
              if(index == 2){
                 Navigator.push(context,MaterialPageRoute(builder: (context) => BookmarksPage()));
              }
              else{
                Fluttertoast.showToast(
              msg: '$index',
              backgroundColor: Colors.black87,
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white);

              }
        },
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: Color(color),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.signOutAlt),
            onPressed: (){
              logout();
            },
          )
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          MyItems(Icons.graphic_eq, "TotalViews", 0xffed622b, 1),
          MyItems(Icons.bookmark, "Bookmark", 0xff26cb3c, 2),
          MyItems(Icons.notifications, "Notification", 0xffff3266, 3),
          MyItems(Icons.attach_money, "Balance", 0xff3399fe, 4),
          MyItems(Icons.settings, "Settings", 0xfff4c83f, 5),
          MyItems(Icons.group_work, "Group Work", 0xff622F74, 6),
          MyItems(Icons.message, "Messages", 0xff7297ff, 7),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, 130.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(1, 150.0),
          StaggeredTile.extent(2, 240.0),
          StaggeredTile.extent(2, 130.0),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Tap to show toast'),
        icon: Icon(FontAwesomeIcons.check,size: 15.0,),
        isExtended: true,
        onPressed: (){
          Fluttertoast.showToast(
            msg: 'A toast msg',
            backgroundColor: Colors.indigo,
            textColor: Colors.white,
            fontSize: 18.0,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_SHORT
          );
        },
      ),
    );
  }
}
