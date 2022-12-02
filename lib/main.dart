import 'package:flutter/material.dart';

import 'package:scooby_app/src/pages/home_page.dart';
import 'package:scooby_app/src/pages/home_page_actores.dart';
import 'package:scooby_app/src/pages/actor_detalle.dart';
import 'package:scooby_app/src/pages/pelicula_detalle.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas TMDB',
      initialRoute: 'menuactores',
      routes: {
        'menuactores': (BuildContext context) => HomePageActores(),
        'menupelis': (BuildContext context) => HomePage(),
        'actor': (BuildContext context) => ActorDetalle(),
        'pelicula': (BuildContext context) => PeliculaDetalle(),
      },
    );
  }
}
