import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_shots/views/splashscreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen(),
    );
  }
}
