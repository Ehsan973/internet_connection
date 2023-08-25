import 'package:flutter/material.dart';
import 'package:internet_connection_app/data/model/user.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({super.key, this.user1});
  User? user1;
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = widget.user1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name : ${user!.name}'),
            ],
          ),
        ),
      ),
    );
  }
}
