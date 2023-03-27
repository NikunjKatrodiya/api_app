import 'dart:convert';

import 'package:api_app/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GetPostScreen extends StatefulWidget {
  const GetPostScreen({Key? key}) : super(key: key);

  @override
  State<GetPostScreen> createState() => _GetPostScreenState();
}

class _GetPostScreenState extends State<GetPostScreen> {
  List<PostModel> postsList = [];
  @override
  void initState() {
    // TODO: implement initState
    getPostAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("get post"),
        centerTitle: true,
      ),
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
                              Text("${postsList[index].id}"),
                              Text("${postsList[index].body}"),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
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
