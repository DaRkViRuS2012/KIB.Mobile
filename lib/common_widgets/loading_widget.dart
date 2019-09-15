import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool visible;

  const LoadingWidget({Key key, @required this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 1300),
      opacity: visible ? 1.0 : 0.0,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5.0),
        alignment: FractionalOffset.center,
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            child: Image(
              image: AssetImage('assets/images/logo.gif'),
            ),
          ),
        ),
      ),
    );
  }
}
