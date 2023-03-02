import 'package:api_app/screens/delete_post_api.dart';
import 'package:api_app/screens/get_post_screen.dart';
import 'package:api_app/screens/put_post_api.dart';
import 'package:api_app/screens/set_post_screen.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const DeletePostScreen(),
    );
  }
}
