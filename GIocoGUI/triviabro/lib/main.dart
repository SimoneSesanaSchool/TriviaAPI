// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'Pages/Menu/Menu.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        /// Titolo programma
        title: "TriviaBro",

        /// Pagina iniziale
        initialRoute: '/menu',

        routes: {
          '/menu': (context) => Menu(),
        });
  }
}