import 'package:flutter/material.dart';
import 'package:fluttertube/api.dart';
import 'package:fluttertube/delegates/data_search.dart';

void main() {
  Api api = Api();
  api.search("Toniolo");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          actions: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Text(
                  "0",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            IconButton(
              icon: Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onPressed: () {},
            ),
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () async {
                  String result = await showSearch(
                      context: context, delegate: DataSearch());
                  print(result);
                },
              ),
            ),
          ],
          title: Container(height: 30, child: Image.asset("image/logo.png")),
          elevation: 0,
        ),
        body: Container(
          color: Colors.black87,
        ),
      ),
    );
  }
}
