import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hbb_customer/bookmarks.dart';
import 'package:hbb_customer/product.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class DetailsPage extends StatefulWidget {
  var title;

  DetailsPage(this.title);

  @override
  _DetailsPageState createState() => new _DetailsPageState(this.title);

  
}

class _DetailsPageState extends State<DetailsPage> {
  var title;

  _DetailsPageState(this.title);

  List<Product> productsList = [];
  Future<List<Product>> fetchPosts() async {
    final response =
        await http.get('http://192.168.0.102/Ayurvedic/load_details.php');

    var data = json.decode(response.body);

    for (var productval in data) {
      Product product = Product(
          p_name: productval['p_name'],
          p_cost: productval['p_cost'],
          p_imgurl: productval['p_imgurl']);
      productsList.add(product);
    }

    return productsList;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> BookmarksPage()));
          },
          child: new Scaffold(
        appBar: AppBar(
          title: Text('Details Page'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
          child: FutureBuilder(
            future: fetchPosts(),
            builder: (context, AsyncSnapshot snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text('$title'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
