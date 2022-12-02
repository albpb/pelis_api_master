import 'package:flutter/material.dart';
import 'package:scooby_app/src/providers/peliculas_provider.dart';
import 'package:scooby_app/src/search/search_delegate.dart';

import 'package:scooby_app/src/widgets/card_swiper_widget.dart';
import 'package:scooby_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
        drawer: Drawer(
          child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  const Text("Menú",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'menuactores');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color: Colors.white,
                      child: Text("Actores"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'menupelis');
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Text("Peliculas"),
                    ),
                  )
                ],
              )),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Peliculas TMDB'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MovieSearch(),
                );
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas(), _footer(context)],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.bodyText1)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
