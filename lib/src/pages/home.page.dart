import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films.provider.dart';
import 'package:flutter_films/src/search/search.delegate.dart';
import 'package:flutter_films/src/widgets/card_swiper.widget.dart';
import 'package:flutter_films/src/widgets/film_horizontal.widget.dart';

class HomePage extends StatelessWidget {
  final _films = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    _films.getPopular();

    return Scaffold(
      appBar: AppBar(
          title: Text('Films on the billboard'),
          backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
            )
          ]),
      body: SafeArea(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardSwiper(),
            _footer(context),
          ],
        ),
      )),
    );
  }

  Widget _cardSwiper() {
    return FutureBuilder(
      future: _films.getOnBillboard(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(films: snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Popular',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: _films.popularStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return FilmHorizontal(films: snapshot.data, nextPage: _films.getPopular,);
              }
              return Center(
                  child: CircularProgressIndicator(),
                );
            },
          )
        ],
      ),
    );
  }
}
