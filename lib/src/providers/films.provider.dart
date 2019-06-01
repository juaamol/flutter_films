import 'dart:async';
import 'dart:convert';

import 'package:flutter_films/secretdata/secretdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_films/src/models/film.model.dart';

class FilmsProvider {
  String _apiKey = SecretData.apiKey;
  String _url = 'api.themoviedb.org';
  String _pathNowPlaying = '/3/movie/now_playing';
  String _pathPopulares = '/3/movie/popular';
  String _language = 'en-US';
  int _popularPage = 0;

  List<Film> _popular = new List(); 

  final StreamController<List<Film>> _popularStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Film>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Film>> _getFilms(String path) async{
    _popularPage++;

    final url = Uri.https(_url, path, {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films = new Films.fromJsonList(decodedData['results']);
    
    _popular.addAll(films.items);
    popularSink(_popular);

    return films.items;
  }

  Future<List<Film>> getOnBillboard() async{
    return _getFilms(_pathNowPlaying);
  }

  Future<List<Film>> getPopular() async{
    return _getFilms(_pathPopulares);
  }
}