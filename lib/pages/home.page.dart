import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 3,
        itemWidth: 200.0,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
        layout: SwiperLayout.STACK,
      ),
    );
  }
}
