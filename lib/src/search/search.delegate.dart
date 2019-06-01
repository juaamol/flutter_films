import 'package:flutter/material.dart';
import 'package:flutter_films/src/models/film.model.dart';
import 'package:flutter_films/src/providers/films.provider.dart';

class DataSearch extends SearchDelegate {
  final _filmsProvider = new FilmsProvider();
  final films = ['Spider-man', 'Captain America', 'Batman', 'Suicide Squad'];
  final recentFilms = ['Spider-man', 'Captain America'];
  String selection = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar actions

    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Left icon of the AppBar
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Creates the results
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Shows suggestions
    if(query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: _filmsProvider.searchFilm(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          final snapFilms = snapshot.data;
          return ListView(
            children: snapFilms.map((Film f) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(
                    f.getPosterImg(),
                  ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(f.title),
                subtitle: Text(f.originalTitle),
                onTap: () {
                  close(context, null);
                  f.uniqueId = '${f.id}-search';
                  Navigator.pushNamed(context, 'detail', arguments: f);
                },
              );
            }).toList(),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }


  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Shows suggestions
  //   final suggestions = (query.isEmpty)
  //       ? recentFilms
  //       : films.where(
  //           (String f) => f.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: suggestions.length,
  //     itemBuilder: (BuildContext context, int index) {
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(suggestions[index]),
  //         onTap: () {
  //           selection = suggestions[index];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }
}
