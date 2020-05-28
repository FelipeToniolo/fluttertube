import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/bloc/favorite_bloc.dart';
import 'package:fluttertube/bloc/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/pages/favorites_page.dart';
import 'package:fluttertube/widgets/videos_tile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              initialData: {},
              stream: BlocProvider.of<FavoriteBloc>(context).outFavorites,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    "${snapshot.data.length}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  );
                else
                  return Container();
              },
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoritesPage()));
            },
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null) bloc.inSearch.add(result);
              },
            ),
          ),
        ],
        title: Container(height: 40, child: Image.asset("image/logo.png")),
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  bloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else
            //Pesquisaa inicial
            bloc.inSearch.add("hulk massinha");
          return Container(
            height: 40,
            width: 40,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
