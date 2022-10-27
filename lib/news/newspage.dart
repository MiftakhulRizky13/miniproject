import 'dart:convert';

import 'package:expensetracker/news/detailnews.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Newspage extends StatefulWidget {
  const Newspage({Key? key}) : super(key: key);

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  List _posts = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News Page',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: Container(
              color: Colors.grey[200],
              height: 100,
              width: 100,
              child: _posts[index]['urlToImage'] != null
                  ? Image.network(
                      _posts[index]['urlToImage'],
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Center(),
            ),
            title: Text('${_posts[index]['title']}',
                maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text(
              '${_posts[index]['description']}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Detail(
                    url: _posts[index]['url'],
                    title: _posts[index]['title'],
                    content: _posts[index]['content'],
                    publishedAt: _posts[index]['publishedAt'],
                    author: _posts[index]['author'],
                    urlToImage: _posts[index]['urlToImage'],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Future _getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newsapi.org/v2/top-headlines?country=sg&category=business&apiKey=8014978f0f2445d28c0f45550f5249ba"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _posts = data['articles'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
