import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  final Function(int, String) onChangedStep;
  PasswordScreen({Key? key, required this.onChangedStep}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _password = "";

  bool _isSecret = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                widget.onChangedStep(0, "");
              },
            )),
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(children: [
              Text("Password".toUpperCase(), style: TextStyle(fontSize: 30)),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Enter your password'),
                      SizedBox(height: 10),
                      TextFormField(
                        onChanged: ((value) => setState(() {
                              _password = value;
                            })),
                        validator: (value) => value!.length < 6
                            ? '6 characters min required'
                            : null,
                        obscureText: _isSecret,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                                onTap: () =>
                                    setState(() => _isSecret = !_isSecret),
                                child: Icon(!_isSecret
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            hintText: 'Ex: ft!/s91d;d',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(color: Colors.grey)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide: BorderSide(color: Colors.grey))),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _password.length < 6
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  print(_password);
                                  widget.onChangedStep(3, _password);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          'Continue'.toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
