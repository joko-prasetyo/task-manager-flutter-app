import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final _task;
  final _userInfo;
  final Function _renderScreen;
  final index;
  Edit(this._task, this._userInfo, this._renderScreen, this.index);
  @override
  _EditState createState() => _EditState(_task, _userInfo, _renderScreen, index);
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _description = new TextEditingController();
  final _userInfo;
  final task;
  final Function _renderScreen;
  final index;
  String _title = "";
  _EditState(this.task, this._userInfo, this._renderScreen, this.index);
  void initState() {
    super.initState();
    _description = TextEditingController(text: '${task[index]["description"]}');
  }

  void _editHandler() async {
    String url =
        'https://babaw-task-manager.herokuapp.com/tasks/${task[index]["_id"]}';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_userInfo['token'].toString()}"
    };
    String body =
        '{"completed": "false", "description": "${_description.text}", "title": "${_title.toString()}"';
    await http.patch(url, headers: headers, body: body);
    task[index]["description"] = _description.text;
    task[index]["title"] = _title;
    Navigator.of(context).pop();
    _renderScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 60, right: 60, top: 30),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Edit task',
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
                    initialValue: task[index]["title"],
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
                        _editHandler();
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
