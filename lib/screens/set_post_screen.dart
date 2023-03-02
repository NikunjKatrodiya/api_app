import 'dart:convert';
import 'package:api_app/model/post_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SetPostScreen extends StatefulWidget {
  const SetPostScreen({Key? key}) : super(key: key);

  @override
  State<SetPostScreen> createState() => _SetPostScreenState();
}

class _SetPostScreenState extends State<SetPostScreen> {
  List<PostModel> postsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set post"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setPostsAPI();
            setState(() {});
          },
          child: const Text("Send Data"),
        ),
      ),
    );
  }

  setPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": 1,
          "it": 101,
          "title": "Nikunj",
          "body": "Katrodiya",
        }),
      );
      if (response.statusCode == 201) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
