import 'package:flutter/material.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/models/service.dart';

import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:url_launcher/url_launcher.dart';

class ProdcutPage extends StatelessWidget {
  final baseURL;
  final index;
  final Service prodcut;
  const ProdcutPage({this.prodcut, this.baseURL, this.index, key})
      : super(key: key);

  viewPDF(link) {
    launch(link);
  }

  @override
  Widget build(BuildContext context) {
    print(prodcut.image(baseURL));
    return Scaffold(
        appBar: getAppBar(title: prodcut.enTitle, context: context),
        body: Material(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    child: TransitionToImage(
                      image: AdvancedNetworkImage(prodcut.image(baseURL),
                          timeoutDuration: Duration(minutes: 1)),
                      // This is the default placeholder widget at loading status,
                      // you can write your own widget with CustomPainter.
                      placeholder: Center(child: CircularProgressIndicator()),
                      // This is default duration
                      duration: Duration(milliseconds: 300),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: Hero(
                            tag: "${prodcut.id}",
                            child: Text(
                              prodcut.enTitle,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        subtitle: Text(
                          prodcut.enDescription,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints.expand(height: 75),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 32.0, right: 32.0, bottom: 16.0),
                    child: FlatButton(
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Style.primaryDarkColor,
                      onPressed: () {
                        print("preseed");
                        viewPDF(prodcut.quotationURL(baseURL));
                      },
                      child: Text(
                        "Buy Now",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
