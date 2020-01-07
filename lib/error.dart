import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'route.dart';

class Error extends StatelessWidget {
  final _userInfo;
  final _fetchData;
  final task;
  Error(this.task, this._userInfo, this._fetchData);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            color: Colors.red,
            size: 75,
            semanticLabel: 'Error',
          ),
          Text(
            'No tasks found',
            style: TextStyle(fontSize: 25),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'Create a new task',
                style: TextStyle(fontSize: 16),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskRoute(task, _userInfo, _fetchData)
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
