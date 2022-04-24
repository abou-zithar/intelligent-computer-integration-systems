import 'package:flutter/material.dart';
import '../models/final_model.dart';

class PostDetail extends StatelessWidget {
  final PC post;

  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(post.line),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text("Title"),
                        subtitle: Text(post.line),
                      ),
                      ListTile(
                        title: Text("ID"),
                        subtitle: Text("${post.line}"),
                      ),
                      ListTile(
                        title: Text("Body"),
                        subtitle: Text(post.line),
                      ),
                      ListTile(
                        title: Text("User ID"),
                        subtitle: Text("${post.line}"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
