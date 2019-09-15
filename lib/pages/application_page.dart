import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../network.dart';

class ApplicationPage extends StatelessWidget {
  final String token;
  final String userId;
  const ApplicationPage({@required this.token, @required this.userId, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var url =
        Network.baseUrl; //+ '/application/' + token + '/' + userId + '/create';
    return Scaffold(
      appBar: getAppBar(title: "new_application", context: context),
      body: Container(
        child: WebView(
          debuggingEnabled: true,
          //application
          initialUrl: url,
        ),
      ),
    );
  }
}
