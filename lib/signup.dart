import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _value = 12;
  Map<Object, String> _body = {};
  final _formKey = GlobalKey<FormState>();
  RegExp regex =
      new RegExp(r"([a-zA-Z]*(\.?[a-zA-Z0-9]+))@[a-zA-Z]+[0-9]?\.com");

  String _emailInput(value) {
    if (value.isEmpty)
      return 'Please enter your email';
    else if (regex.stringMatch(value).length != value.length)
      return 'Invalid email';
    _body["email"] = value.toString();
    return null;
  }

  String _passInput(value) {
    if (value.isEmpty)
      return 'Please input your password';
    else if (value.length < 8)
      return 'Password should be greater than 8 characters';
    _body["password"] = value.toString();
    return null;
  }

  Future<void> _registerHandler() async {
    _body["age"] = _value.toString();
    String url = 'https://babaw-task-manager.herokuapp.com/users';
    Map<String, String> headers = {"Content-type": "application/json"};
    Response response =
        await post(url, headers: headers, body: jsonEncode(_body));
    int statusCode = response.statusCode;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: statusCode == 201
              ? Text('Account has been created')
              : Text('Failed to register'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                statusCode == 201
                    ? Text(
                        'Thanks for registering an account, we gladly to see you as soon as possible. Please login to your account')
                    : Text('Account is already registered. Please try again')
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            'Sign up a new account',
            maxLines: 1,
            minFontSize: 30,
            overflow: TextOverflow.ellipsis,
          ),
          Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 50, right: 50, top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please input your name';
                        else if (value.length < 4)
                          return 'Name should be more than 3 characters';
                        _body["name"] = value.toString();
                        return null;
                      },
                      decoration: InputDecoration(hintText: 'Full Name'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text('Set age: '),
                        Slider(
                          min: 12,
                          max: 70,
                          divisions: 58,
                          label: 'Set your age (${_value.round()} years old)',
                          value: _value.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _value = newValue.round();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      validator: _emailInput,
                      decoration: InputDecoration(
                          hintText: 'Username or Email address'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      validator: _passInput,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: ButtonTheme(
                      minWidth: double.infinity,
                      height: 50,
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: AutoSizeText(
                          'Register',
                          maxLines: 1,
                          minFontSize: 20,
                          maxFontSize: 30,
                          overflow: TextOverflow.ellipsis,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _registerHandler();
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text('Already have an account ?'),
                        ),
                        ButtonTheme(
                          minWidth: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.orange,
                            child: AutoSizeText(
                              'Login with an existing account',
                              maxLines: 1,
                              minFontSize: 10,
                              maxFontSize: 30,
                              overflow: TextOverflow.ellipsis,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
