import 'dart:convert';

import 'package:flutter_films/secret/secretdata.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_films/src/models/film.model.dart';

class FilmsProvider {
  String _apiKey = SecretData.apiKey;
  String _url = 'api.themoviedb.org';
  String _pathNowPlaying = '/3/movie/now_playing';
  String _pathPopulares = '/3/movie/popular';
  String _language = 'en-US';

  Future<List<Film>> _getFilms(String path) async{
    final url = Uri.https(_url, path, {
      'api_key': _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final films = new Films.fromJsonList(decodedData['results']);
    
    return films.items;
  }

  Future<List<Film>> getOnBillboard() async{
    return _getFilms(_pathNowPlaying);
  }

  Future<List<Film>> getPopular() async{
    return _getFilms(_pathPopulares);
  }
}