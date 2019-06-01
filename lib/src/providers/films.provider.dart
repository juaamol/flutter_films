import 'dart:async';
import 'dart:convert';

import 'package:flutter_films/secretdata/secretdata.dart';
import 'package:flutter_films/src/models/actor.model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_films/src/models/film.model.dart';

class FilmsProvider {
  String _apiKey = SecretData.apiKey;
  String _url = 'api.themoviedb.org';
  String _pathNowPlaying = '/3/movie/now_playing';
  String _pathPopulares = '/3/movie/popular';
  String _language = 'en-US';
  int _popularPage = 0;
  bool _loading = false;

  List<Film> _popular = new List();

  final StreamController<List<Film>> _popularStreamController =
      StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Film>> get popularStream => _popularStreamController.stream;

  void disposeStreams() {
    _popularStreamController?.close();
  }

  Future<List<Film>> _getFilms(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films = new Films.fromJsonList(decodedData['results']);

    return films.items;
  }

  Future<List<Film>> getPopular() async {
    if(_loading) return [];

    _loading = true;
    _popularPage++;

    final url = Uri.https(_url, _pathPopulares, {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    List<Film> popularFilms = await _getFilms(url);

    _popular.addAll(popularFilms);
    popularSink(_popular);

    _loading = false;
    return popularFilms;
  }

  Future<List<Film>> getOnBillboard() async {
    final url = Uri.https(_url, _pathNowPlaying, {
      'api_key': _apiKey,
      'language': _language
    });

    return _getFilms(url);
  }

  Future<List<Actor>> getCast(String filmId) async {
    final url = Uri.https(_url, '/3/movie/$filmId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actors;
  }
}
