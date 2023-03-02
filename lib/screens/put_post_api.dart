import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:api_app/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PutPostScreen extends StatefulWidget {
  const PutPostScreen({Key? key}) : super(key: key);

  @override
  State<PutPostScreen> createState() => _PutPostScreenState();
}

class _PutPostScreenState extends State<PutPostScreen> {
  List<PostModel> postsList = [];
  @override
  void initState() {
    // TODO: implement initState
    getPostAPI();
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Put Post Screen"),
      ),

      // body: characterModal == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : ListView.separated(
      //         itemCount: characterModal!.results!.length,
      //         separatorBuilder: (context, index) => const SizedBox(height: 15),
      //         itemBuilder: (context, index) => ListTile(
      //           tileColor: Colors.green,
      //           leading: Image.network(characterModal!.results![index].image!),
      //           title: Text(characterModal!.results![index].name!),
      //           subtitle: Text(characterModal!.results![index].status!),
      //         ),
      //       ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: postsList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemCount: postsList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) => Container(
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(postsList[index].title!),
                              Text(postsList[index].body!),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            ElevatedButton(
                onPressed: () {
                  putPostsAPI();
                  setState(() {});
                },
                child: const Text("Put Post"))
          ],
        ),
      ),
    );
  }

  putPostsAPI() async {
    Client client = http.Client();
    try {
      Response response = await client.put(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "userId": 11,
          "it": 101,
          "title": "Nikunj",
          "body": "Katrodiya",
        }),
      );
      debugPrint("Status Code -------------->>> ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint("Response -------------->>> ${jsonDecode(response.body)}");
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }

  getPostAPI() async {
    var client = http.Client();
    try {
      Response response = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );
      if (response.statusCode == 200) {
        postsList = (jsonDecode(response.body) as List?)!
            .map((dynamic e) => PostModel.fromJson(e))
            .toList();
        //  postsModal = PostsModal.fromJson(jsonDecode(response.body));
        setState(() {});
      } else {
        debugPrint("Status Code -------------->>> ${response.statusCode}");
      }
    } finally {
      client.close();
    }
  }
}
