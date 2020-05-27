import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/bloc/favorite_bloc.dart';
import 'package:fluttertube/bloc/videos_bloc.dart';
import 'package:fluttertube/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: VideosBloc(),
        child: BlocProvider(
            bloc: FavoriteBloc(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: HomePage())));
  }
}
