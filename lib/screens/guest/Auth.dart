// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final Function(int, String) onChangedStep;

  AuthScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  String _email = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Everyone has \n'.toUpperCase(),
                      style: TextStyle(color: Colors.black, fontSize: 30),
                      children: [
                        TextSpan(
                            text: 'knowledge\n'.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(text: "to share".toUpperCase())
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('It all starts here',
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  SizedBox(height: 50.0),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Enter your email'),
                          SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) => {
                              setState(
                                () => _email = value,
                              )
                            },
                            validator: (value) => value == "" ||
                                    value == null ||
                                    !emailRegex.hasMatch(value)
                                ? "Please enter a valid email"
                                : null,
                            decoration: InputDecoration(
                                hintText: 'Ex: hugo.lamoureux18@gmail.com',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide: BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0),
                                    borderSide:
                                        BorderSide(color: Colors.grey))),
                          ),
                          SizedBox(height: 10),
                          RaisedButton(
                            onPressed: !emailRegex.hasMatch(_email)
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      print(_email);
                                      widget.onChangedStep(1, _email);
                                    }
                                  },
                            elevation: 0,
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Continue'.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
