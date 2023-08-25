import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:internet_connection_app/data/model/user.dart';
import 'package:internet_connection_app/screens/second_screen.dart';
import 'package:internet_connection_app/screens/user_profile_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'loading...';
  String username = 'Username';
  String city = 'Usercity';
  int user_index = 0;
  List<User> users_list = [];
  var decoded_data;
  bool isTitleLoading = false;
  bool isUsersLoading = false;

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
                child: Column(
                  children: [
                    Text(
                      'Title : $title',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Visibility(
                      visible: isTitleLoading,
                      child: SpinKitFadingCircle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                width: 300,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Username :\n\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${username}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text('City : ${city}'),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (user_index > 0 && users_list.length != 0) {
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
                                if (user_index < 9 && users_list.length != 0) {
                                  user_index++;
                                  if (user_index >= users_list.length) {
                                    var user = _createUser();
                                    users_list.add(user);
                                  }
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (users_list.length == 0) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                        user1: users_list[user_index],
                      ),
                    ),
                  );
                },
                child: Text('show user profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isTitleLoading = true;
                  });
                  _getData();
                },
                child: Text('Click to get data'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUsersLoading = true;
                  });
                  _getUserData();
                },
                child: Text('Get user data'),
              ),
              SizedBox(height: 20),
              Visibility(
                visible: isUsersLoading,
                child: SpinKitThreeBounce(
                  color: Colors.amber,
                  size: 40,
                ),
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
      isTitleLoading = false;
    });
  }

  void _getUserData() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var resonse = await get(uri);
    decoded_data = jsonDecode(resonse.body);
    users_list.add(_createUser());
    _updateUser();
    setState(() {
      isUsersLoading = false;
    });
  }

  void _updateUser() {
    setState(() {
      username = users_list[user_index].username;
      city = users_list[user_index].city;
    });
  }

  User _createUser() {
    var user = User(
      decoded_data[user_index]['id'],
      decoded_data[user_index]['name'],
      decoded_data[user_index]['username'],
      decoded_data[user_index]['address']['city'],
      decoded_data[user_index]['phone'],
    );
    return user;
  }
}
