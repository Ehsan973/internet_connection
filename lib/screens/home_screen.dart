import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_app/screens/second_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'loading...';
  String name = 'Username';
  String city = 'Usercity';
  int user_index = 0;
  var decoded_data;

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
              Container(
                height: 200,
                width: 250,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    children: [
                      Text('Name : ${name}'),
                      Text('City : ${city}'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (user_index > 0) {
                                  user_index--;
                                  _updateUser();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(90, 30),
                              ),
                              child: Text('Previous'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (user_index < 9) {
                                  user_index++;
                                  _updateUser();
                                }
                              },
                              child: Text('Next'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(90, 30),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                  width: 3,
                )),
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
                child: Text('Click to get data'),
              ),
              ElevatedButton(
                onPressed: () {
                  _getUserData();
                },
                child: Text('Get user data'),
              ),
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

  void _getUserData() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var resonse = await get(uri);
    decoded_data = jsonDecode(resonse.body);
    _updateUser();
  }

  void _updateUser() {
    setState(() {
      name = decoded_data[user_index]['name'];
      city = decoded_data[user_index]['address']['city'];
    });
  }
}
