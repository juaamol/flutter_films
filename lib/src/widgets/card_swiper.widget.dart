import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> films;

  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect (
           child:Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.cover,
          ), 
          borderRadius: BorderRadius.circular(20.0),);
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        
      ),
    );
  }
}
