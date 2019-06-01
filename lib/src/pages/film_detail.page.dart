import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_films/src/models/film.model.dart';

class FilmDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      body: Center(child: Text(film.title),)
    );
  }
}