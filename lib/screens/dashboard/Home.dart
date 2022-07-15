import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test1/screens/Guest.dart';
import 'package:test1/services/UserService.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: ElevatedButton(
      onPressed: (() async {
        await _userService.logout();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GuestScreen()),
            (route) => false);
      }),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        primary: Theme.of(context).primaryColor,
      ),
      child: Text(
        'logout'.toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    ))));
  }
}
