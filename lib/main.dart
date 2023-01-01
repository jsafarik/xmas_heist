import 'package:flutter/material.dart';

import 'pages/bomb.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scavenger hunt',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: const Scaffold(
        body: Bomb(pin: "j034"),
      ),
    );
  }
}
