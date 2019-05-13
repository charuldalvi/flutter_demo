import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hbb_customer/detailspage.dart';
import 'package:hbb_customer/product.dart';
import 'package:http/http.dart' as http;

class BookmarksPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookmarksPageState();
  }
}

class _BookmarksPageState extends State<BookmarksPage> {

  

  List<Product> productsList = [];
  Future<List<Product>> fetchPosts() async {
    final response =
        await http.get('http://192.168.0.102/Ayurvedic/fetch_products.php');

    var data = json.decode(response.body);

    for (var productval in data) {
      Product product = Product(
          p_id: productval['p_id'],
          p_name: productval['p_name'],
          p_cost: productval['p_cost'],
          p_imgurl: productval['p_imgurl']);
      productsList.add(product);
    }

    return productsList;
  }


  Future delete(BuildContext context, Product product) async {
    http.Response response;

        response = await http.post(
        'http://192.168.1.13/Ayurvedic/delete_product.php',
        body: {'p_id': product.p_id});

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
        centerTitle: true,
      ),
      body: buildFutureBuilder(),
    );
  }






  FutureBuilder<List<Product>> buildFutureBuilder() {
    return FutureBuilder(
      future: fetchPosts(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.active:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.none:
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ConnectionState.done:
            if (snapshot.error != null) {
              return Container(
                child: Center(
                  child: Text('Something went Wrong!!'),
                ),
              );
            } else {
              return Container(
                child: ListView.builder(
                  itemCount: productsList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      snapshot.data[index].p_name)));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://192.168.0.102/Ayurvedic/' +
                                  snapshot.data[index].p_imgurl),
                        ),
                        title: Text(snapshot.data[index].p_name),
                        subtitle: Text(snapshot.data[index].p_cost),
                        trailing: GestureDetector(
                          onTap: () {
                            delete(context, productsList[index]);
                            setState(() {
                              productsList.clear();
                            });
                          },
                          child: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
        }
      },
    );
  }
}
