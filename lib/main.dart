import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracks/Services/connectivity.dart';
import 'package:tracks/repository/track_Repository.dart';
import 'package:flutter/material.dart';
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trending',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => TrackRepositoryImpl()),
          RepositoryProvider(create: (context) => ConnectivityService()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
