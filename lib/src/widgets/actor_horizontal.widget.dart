import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/actor.model.dart';

class ActorHorizontal extends StatelessWidget {
  final List<Actor> actors;
  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);

  ActorHorizontal({@required this.actors});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          return _card(context, actors[index]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Actor actor) {
    final card = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(actor.getFoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              actor.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );

      return card;
  }
}
