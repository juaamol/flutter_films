import 'package:flutter/material.dart';
import 'package:flutter_films/src/providers/films.provider.dart';
import 'package:flutter_films/src/widgets/card_swiper.widget.dart';

class HomePage extends StatelessWidget {
  final _films = FilmsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Films on the billboard'),
          backgroundColor: Colors.indigo,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {

              },
            )
          ]
          ),
      body: SafeArea(child: Container(
        child: Column(
          children: <Widget>[
            _cardSwiper()
          ],
        ),
      )),
    );
  }

  Widget _cardSwiper() {
    FutureBuilder(
      future: _films.getOnBillboard(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {

        if(snapshot.hasData) {
          return CardSwiper(
          films: snapshot.data);
        }
          return Container(
            height: 400.0,
            child: CircularProgressIndicator(),
          ); 
      },
    );
  }
}
