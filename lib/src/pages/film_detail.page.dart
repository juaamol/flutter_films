import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_films/src/models/film.model.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film film = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(film),
          SliverFillRemaining(),
        ],
      ),
    );
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(film.title, style: TextStyle(color: Colors.white, fontSize: 16.0,),),
        background: FadeInImage(
          image: NetworkImage(film.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 250),
          fit: BoxFit.cover
        ),
      ),
    );
  }
}
