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

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('Popular', style: Theme.of(context).textTheme.subhead,),
          FutureBuilder(
            future: _films.getPopular(),
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
          )
        ],
      ),
    );
  }
}
