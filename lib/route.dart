import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import 'edit.dart';
import 'components/add.dart';
import 'addtask.dart';
import 'components/cardlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: SignUp(),
    );
  }
}

class HomeRoute extends StatefulWidget {
  final _userInfo;
  HomeRoute(this._userInfo);
  @override
  _HomeRouteState createState() => _HomeRouteState(_userInfo);
}

class _HomeRouteState extends State<HomeRoute> {
  final _userInfo;
  _HomeRouteState(this._userInfo);
  List<Object> task = [];
  List<Widget> taskslist = [];
  bool isEmpty = false;

  void _renderScreen() {
    taskslist = [];
    setState(() {
      if (task.length > 0) {
        for (int i = 0; i < task.length; i++) {
          taskslist.add(CardList(task, _userInfo, _renderScreen, i));
        }
        isEmpty = false;
      } else
        isEmpty = true;
    });
  }

  void _fetchData() async {
    String url =
        'https://babaw-task-manager.herokuapp.com/tasks?sortBy=createdAt:desc';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_userInfo['token'].toString()}"
    };
    var response = await http.get(url, headers: headers);
    task = jsonDecode(response.body);
    setState(() {
      if (task.length > 0) {
        for (int i = 0; i < task.length; i++) {
          taskslist.add(CardList(task, _userInfo, _renderScreen, i));
        }
        isEmpty = false;
      } else
        isEmpty = true;
    });
  }

  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Home'),
            ),
            body: Home(_userInfo, task, taskslist, isEmpty, _renderScreen),
          )
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Home'),
            ),
            body: Home(_userInfo, task, taskslist, isEmpty, _renderScreen),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddTaskRoute(task, _userInfo, _renderScreen),
                  ),
                );
              },
              child: Icon(Icons.add, size: 30),
              backgroundColor: Colors.green,
            ),
          );
  }
}

class EditRoute extends StatelessWidget {
  final task;
  final _userInfo;
  final Function _renderScreen;
  final index;
  EditRoute(this.task, this._userInfo, this._renderScreen, this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Edit(task, _userInfo, _renderScreen, index),
    );
  }
}

class AddRoute extends StatelessWidget {
  final _userInfo;
  final Function _fetchData;
  final task;
  AddRoute(this.task, this._userInfo, this._fetchData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: Add(task, _userInfo, _fetchData),
    );
  }
}

class AddTaskRoute extends StatelessWidget {
  final _userInfo;
  final Function _renderScreen;
  final task;
  AddTaskRoute(this.task, this._userInfo, this._renderScreen);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: AddTask(task, _userInfo, _renderScreen),
    );
  }
}
