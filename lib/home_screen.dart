import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_app/second_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'loading...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 300,
                child: Text(
                  'Title : $title',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ),
                  );
                },
                child: Text('Go to second screen'),
              ),
              ElevatedButton(
                  onPressed: () {
                    _getData();
                  },
                  child: Text('Click to get data')),
            ],
          ),
        ),
      ),
    );
  }

  void _getData() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    Response resonse = await get(uri);
    var title1 = jsonDecode(resonse.body)['title'];

    setState(() {
      title = title1;
    });
  }
}

// initState and deactivate methods and get data from internet(http, jsonDecode, ...)