import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State {
  bool _isLoading = false;
  Map<Object, String> _data = {};
  RegExp regex =
      new RegExp(r"([a-zA-Z]+(\.?[a-zA-Z0-9]+)*)@[a-zA-Z]+[0-9]?\.(com|co.id)");
  String _emailInput(value) {
    if (value.isEmpty)
      return 'Please enter your email';
    else if (regex.stringMatch(value).length != value.length)
      return 'Invalid email';
    _data["email"] = value.toString();
    return null;
  }

  String _passInput(value) {
    if (value.isEmpty)
      return 'Please input the password';
    else if (value.length < 8)
      return 'Password must be greater than 7 characters';
    _data["password"] = value.toString();
    return null;
  }

  void _setIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    _data = {};
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Login(_emailInput, _passInput, _data, _setIsLoading, _isLoading),
      ),
    );
  }
}
