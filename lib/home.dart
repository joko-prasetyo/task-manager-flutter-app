import 'package:flutter/material.dart';
import 'error.dart';

class Home extends StatelessWidget {
  final _userInfo;
  final task;
  final List<Widget> taskslist;
  final isEmpty;
  final Function _renderScreen;
  Home(this._userInfo, this.task, this.taskslist, this.isEmpty,
      this._renderScreen);
  @override
  Widget build(BuildContext context) {
    return taskslist.length == 0
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isEmpty
                    ? Error(task, _userInfo, _renderScreen)
                    : Text('Loading...'),
              ],
            ),
          )
        : SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Stack(
                  children: [
                    Column(
                      children: taskslist.map<Widget>((item) => item).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
