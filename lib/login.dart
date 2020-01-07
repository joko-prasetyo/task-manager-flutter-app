import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'route.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatelessWidget {
  final bool isEmpty = false;
  final _formKey = GlobalKey<FormState>();
  final Function _emailHandler;
  final Function _passHandler;
  final Map<Object, String> _data;
  final Function _setIsLoading;
  final _isLoading;
  Login(this._emailHandler, this._passHandler, this._data, this._setIsLoading,
      this._isLoading);

  Future<void> _loginHandler(context) async {
    _setIsLoading();
    String url = 'https://babaw-task-manager.herokuapp.com/users/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = jsonEncode(_data);
    Response response = await post(url, headers: headers, body: json);
    _setIsLoading();
    int statusCode = response.statusCode;
    Map _userInfo = jsonDecode(response.body);
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeRoute(_userInfo),
                  ),
                );
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
        children: !_isLoading
            ? [
                Text(
                  'Sign in',
                  style: TextStyle(fontSize: 40),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            validator: _emailHandler,
                            decoration: InputDecoration(
                                hintText: 'Username or Email address'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            validator: _passHandler,
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
                                'Login',
                                maxLines: 1,
                                minFontSize: 20,
                                maxFontSize: 30,
                                overflow: TextOverflow.ellipsis,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _loginHandler(context);
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 10),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text('Do not have any account ?'),
                              ),
                              ButtonTheme(
                                minWidth: double.infinity,
                                height: 50,
                                child: RaisedButton(
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  child: AutoSizeText(
                                    'Create a new one',
                                    maxLines: 1,
                                    minFontSize: 20,
                                    maxFontSize: 30,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpRoute(),
                                      ),
                                    );
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
              ]
            : [
                SpinKitFoldingCube(
                  color: Colors.blue,
                  size: 50.0,
                )
              ],
      ),
    );
  }
}
