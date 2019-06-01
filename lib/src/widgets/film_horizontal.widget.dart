import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film.model.dart';

class FilmHorizontal extends StatelessWidget {
  final List<Film> films;
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function nextPage;

  FilmHorizontal({@required this.films, @required this.nextPage});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context),
        itemCount: films.length,
        itemBuilder: (BuildContext context, int index) {
          return _card(context, films[index]);
        },
      ),
    );
  }

  Widget _card(BuildContext context, Film film) {
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: film.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(film.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            film.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: film);
      },
    );
  }
}
