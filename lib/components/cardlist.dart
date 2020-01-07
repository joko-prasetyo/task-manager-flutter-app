import 'package:flutter/material.dart';
import '../route.dart';
import 'package:http/http.dart' as http;

class CardList extends StatelessWidget {
  final task;
  final _userInfo;
  final index;
  final Function _renderScreen;
  CardList(this.task, this._userInfo, this._renderScreen, this.index);
  void _deleteHandler() async {
    String url =
        'https://babaw-task-manager.herokuapp.com/tasks/${task[index]["_id"]}';
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_userInfo['token'].toString()}"
    };
    await http.delete(url, headers: headers);
    task.removeAt(index);
    _renderScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  EditRoute(task, _userInfo, _renderScreen, index),
            ),
          );
        },
        child: Container(
          width: 400,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Title: ${task[index]["title"]}',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.yellow,
                                size: 30,
                                semanticLabel: 'Edit tasks',
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditRoute(
                                        task, _userInfo, _renderScreen, index),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.red,
                                semanticLabel: 'Delete Tasks',
                              ),
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete this task ?'),
                                      content: Text(
                                          'This will permanently delete the task. Are you sure about this ?'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('Yes'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            _deleteHandler();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            // Icon(
                            //   Icons.settings,
                            //   color: Colors.grey,
                            //   size: 30,
                            //   semanticLabel: 'Settings',
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                width: double.infinity,
                color: Colors.grey,
                height: 0.5,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  '${task[index]["description"].toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
