import 'package:flutter/material.dart';
import 'home.dart';
import 'authentication.dart';
import 'pages/profile.dart';

void main() async {
  runApp(new MainApp());
}

class MainApp extends StatelessWidget {

  final routes = <String, WidgetBuilder> {
    MyHomePage.tag: (context) => MyHomePage(),
    HomePage.tag: (context) => HomePage(),
    ProfilePage.tag: (context) => ProfilePage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}

