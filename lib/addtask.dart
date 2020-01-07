import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTask extends StatefulWidget {
  final _userInfo;
  final Function _renderScreen;
  final task;
  AddTask(this.task, this._userInfo, this._renderScreen);
  @override
  _AddTaskState createState() => _AddTaskState(task, _userInfo, _renderScreen);
}

class _AddTaskState extends State {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _description = new TextEditingController();
  final _userInfo;
  final Function _renderScreen;
  final task;
  String _title = "";
  _AddTaskState(this.task, this._userInfo, this._renderScreen);
  void _addHandler() async {
    String url = 'https://babaw-task-manager.herokuapp.com/tasks';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_userInfo['token'].toString()}"
    };
    String body =
        '{"completed":"false", "description":"${_description.text}", "title":"${_title.toString()}"}';
    var response = await http.post(url, headers: headers, body: body);
    Navigator.of(context).pop();
    task.insert(0, jsonDecode(response.body));
    _renderScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Add task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) return 'Title should not be empty';
                      _title = value;
                      return null;
                    },
                    decoration: InputDecoration(hintText: 'Title'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextField(
                    controller: _description,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(hintText: 'Description'),
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.green,
                    child: Text(
                      'Confirm',
                      style: TextStyle(fontSize: 16),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _addHandler();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
