import 'package:flutter/material.dart';
import 'package:kib/common_widgets/styles.dart';

// import '../localization.dart';

mixin UserFeedback {
  void showInSnackBar(String value, BuildContext context,
      {Color color = Style.primaryLightColor}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Scaffold.of(context)?.removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        // AppLocalizations.of(context).trans(value),
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 3),
    ));
  }
}
