import 'package:flutter/material.dart';
import 'package:scooby_app/src/providers/actores_provider.dart';
import 'package:scooby_app/src/search/search_delagate_actors.dart';
import 'package:scooby_app/src/search/search_delegate.dart';

import 'package:scooby_app/src/widgets/card_swiper_widget_actores.dart';

class HomePageActores extends StatelessWidget {
  final actoresProvider = new ActoresProvider();

  @override
  Widget build(BuildContext context) {
    actoresProvider.getPopulares();

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
                      color: Colors.grey[100],
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
                      color: Colors.white,
                      child: Text("Peliculas"),
                    ),
                  )
                ],
              )),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Actorazos'),
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: ActorSearch(),
                );
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[_swiperTarjetas()],
          ),
        ));
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
      future: actoresProvider.getPopulares(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(actores: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
