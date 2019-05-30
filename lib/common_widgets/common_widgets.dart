import 'package:flutter/material.dart';
import 'package:kib/common_widgets/localized_text.dart';

Widget getAppBar({title, context}) {
  return AppBar(
    title: new LocalizedText(
      title,
      style: TextStyle(color: Colors.black),
    ),
    elevation:
        0.0, //Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 3.0,
    backgroundColor: Colors.transparent,
    leading: Hero(
      tag: "logo",
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Logo.png'))),
          ),
        ),
      ),
    ),
  );
}

// List<Widget> buildActions(context) {
//   return <Widget>[searchAction(context), infoAction(context)];
// }

// IconButton searchAction(context) {
//   return IconButton(
//       icon: Icon(Icons.search),
//       onPressed: () => Router.goToSearchScreen(context));
// }

// IconButton infoAction(context) {
//   return IconButton(
//       icon: Icon(Icons.info_outline),
//       onPressed: () => showModalBottomSheet(
//           context: context, builder: (BuildContext context) => InfoView()));
// }
