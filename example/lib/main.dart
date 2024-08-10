import 'package:easy_overlay/easy_overlay.dart';
import 'package:flutter/material.dart';
import 'package:example/home.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      builder: EasyOverlay.init(),
      debugShowCheckedModeBanner: false,
    );
  }
}
