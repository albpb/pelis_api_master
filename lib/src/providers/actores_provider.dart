import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'package:scooby_app/src/models/actores_model.dart';
import 'package:scooby_app/src/models/pelicula_model.dart';

class ActoresProvider {
  String _apikey = '29b907d5ad39d88c1c1f53647f9e7e45';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Actor> _populares = [];

  final _popularesStreamController = StreamController<List<Actor>>.broadcast();

  Function(List<Actor>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Actor>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Actor>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final actores = new Actores.fromJsonList(decodedData['results']);

    for (var i = 0; i < actores.actores.length; i++) {
      var respDesc = await http.get(Uri.https(
          _url,
          '3/person/' + actores.actores[i].id.toString(),
          {'api_key': _apikey, 'language': _language}));
      var dataDesc = await json.decode(respDesc.body);

      actores.actores[i].description = dataDesc["biography"];
    }

    return actores.actores;
  }

  Future<List<Actor>> getActores() async {
    final url = Uri.https(_url, '3/person/',
        {'api_key': _apikey, 'language': _language}); // Pelicula
    return await _procesarRespuesta(url);
  }

  Future<List<Actor>> getPopulares() async {
    /*if (_cargando) return [];

    _cargando = true;
    */
    _popularesPage++;

/*
    final url = Uri.https(_url, '3/person/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });
    */
    final url = Uri.https(
        _url, '3/person/popular', {'api_key': _apikey, 'language': _language});

    final resp = await _procesarRespuesta(url);
/*
    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    */
    return resp;
  }

  Future<List<Pelicula>> getCast(String personId) async {
    final url = Uri.https(_url, '3/person/$personId/movie_credits',
        {'api_key': _apikey, 'language': _language}); // pelicula

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final peliculas = new Peliculas.fromJsonList(decodedData['cast']);

    return peliculas.items;
  }

  Future<List<Actor>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/person', {
      'api_key': _apikey,
      'language': _language,
      'query': query
    }); // Pelicula

    return await _procesarRespuesta(url);
  }
}
