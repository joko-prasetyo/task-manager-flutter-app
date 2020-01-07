import 'package:flutter/material.dart';
import '../route.dart';

class Add extends StatelessWidget {
  final _userInfo;
  final Function _renderScreen;
  final task;
  Add(this.task, this._userInfo, this._renderScreen);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskRoute(task, _userInfo, _renderScreen),
            ),
          );
        },
        child: Container(
          width: 400,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 60,
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
