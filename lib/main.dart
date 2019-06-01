import 'package:flutter/material.dart';
import 'package:flutter_films/src/pages/film_detail.page.dart';
import 'package:flutter_films/src/pages/home.page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'detail': (BuildContext context) => FilmDetail(),
      },
    );
  }
}