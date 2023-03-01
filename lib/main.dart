import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:tmdb_using_bloc/repository/movie_repo.dart';
import 'package:tmdb_using_bloc/screens/bloc_homepage.dart';

import 'model/movie.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primarySwatch: Colors.grey, brightness: Brightness.dark),
        home: RepositoryProvider(
            create: (context) => MovieRepo(), child: BlocHomePage())

        // home: HomePage(),
        );
  }
}
