import 'package:flutter/material.dart';
import 'package:test1/models/UserModel.dart';
import 'package:test1/screens/dashboard/Home.dart';
import 'package:test1/screens/guest/Auth.dart';
import 'package:test1/screens/guest/Password.dart';
import 'package:test1/screens/guest/Term.dart';
import 'package:test1/services/CommonService.dart';
import 'package:test1/services/UserService.dart';

class GuestScreen extends StatefulWidget {
  GuestScreen({Key? key}) : super(key: key);

  @override
  State<GuestScreen> createState() => _GuestScreenState();
}

class _GuestScreenState extends State<GuestScreen> {
  CommonService _commonService = CommonService();
  UserService _userService = UserService();

  List<Widget> _widgets = [];
  int _indexSelected = 0;
  late String _email;

  @override
  void initState() {
    super.initState();

    _commonService.terms.then((terms) {
      setState(() {
        _widgets.addAll([
          AuthScreen(
            onChangedStep: (index, value) => setState(() {
              _indexSelected = index;
              _email = value;
            }),
          ),
          TermScreen(
              terms: terms,
              onChangedStep: (index) => setState(() => _indexSelected = index)),
          PasswordScreen(
              onChangedStep: (index, value) => setState(() {
                    if (index != 3) {
                      _indexSelected = index;
                    }
                    if (value != "") {
                      _userService
                          .auth(UserModel(email: _email, password: value))
                          .then((value) {
                        if (value != "" && value != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      });
                    }
                  }))
        ]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _widgets.length == 0
            ? SafeArea(
                child: Scaffold(
                  body: Center(
                    child: Text("Loading"),
                  ),
                ),
              )
            : _widgets.elementAt(_indexSelected));
  }
}
