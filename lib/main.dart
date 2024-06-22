import 'package:flutter/material.dart';
import 'package:fouzy/view/bottombar.dart';
import 'package:fouzy/view/homescreen.dart';
import 'package:fouzy/view/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  Splashscreen(),
      home:  BottomNavBar(),

    );
  }
}

