import 'package:flutter/material.dart';
class Alert extends StatelessWidget {
  final int statusCode;
  Alert(this.statusCode);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: statusCode == 200
          ? Text('Login success')
          : Text('Invalid credentials'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            statusCode == 200
                ? Text('Welcome to the app')
                : Text('Wrong email and password')
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
  }
}
