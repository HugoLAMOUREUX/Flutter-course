import 'package:flutter/material.dart';
import 'package:test1/screens/Guest.dart';
import 'package:test1/screens/dashboard/Home.dart';
import 'package:test1/screens/guest/Auth.dart';
import 'package:test1/screens/guest/Password.dart';
import 'package:test1/screens/guest/Term.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test1/services/UserService.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(App());
}

class App extends StatelessWidget {
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projet apprentissage',
        home: StreamBuilder(
            stream: _userService.user,
            builder: (context, snapshot) {
              print(snapshot.connectionState);

              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return HomeScreen();
                }

                return GuestScreen();
              }

              return SafeArea(
                  child: Scaffold(body: Center(child: Text("Loading..."))));
            }));
  }
}
