import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:fluttertube/alert.dart';
import 'package:fluttertube/bloc/favorite_bloc.dart';
import 'package:fluttertube/credentials.dart';

import '../models/video.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
          stream: bloc.outFavorites,
          initialData: {},
          builder: (context, snapshot) {
            return ListView(
              children: snapshot.data.values.map((v) {
                return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: getKey(), videoId: v.id);
                  },
                  onLongPress: () {
                    alert(context, v);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 100,
                        child: Image.network(v.thumb),
                      ),
                      Expanded(
                        child: Text(
                          v.title,
                          style: TextStyle(color: Colors.white70),
                          maxLines: 2,
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          }),
    );
  }
}
