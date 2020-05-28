import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/bloc/favorite_bloc.dart';
import 'package:fluttertube/models/video.dart';

alert(BuildContext context, Video video) {
  final bloc = BlocProvider.of<FavoriteBloc>(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("ArThube"),
          content: Text("Deseja remover este video dos favoritos?"),
          actions: <Widget>[
            FlatButton(
              child: Text("CONFIRMAR"),
              onPressed: () {
                bloc.toggleFavorite(video);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("CANCELAR"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
