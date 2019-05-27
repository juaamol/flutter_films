import 'package:flutter/material.dart';
import 'package:flutter_films/pages/home.page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage()
      },
    );
  }
}