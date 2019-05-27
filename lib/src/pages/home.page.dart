import 'package:flutter/material.dart';
import 'package:flutter_films/src/widgets/card_swiper.widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
    return CardSwiper(
      peliculas: [1,2,3,4,5],
    );
  }
}
