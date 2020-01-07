import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ShowLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SpinKitFoldingCube(
              color: Colors.blue,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
