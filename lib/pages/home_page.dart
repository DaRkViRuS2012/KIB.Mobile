import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/radial_menu.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/dataStore/dataStore.dart';
import 'package:kib/localization.dart';
import 'package:kib/main.dart';
import 'auth/profile_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  var map = {};
  var title = "";
  var body = {};
  var myToken = "";

  initFireBase() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        map = message;
        showNotification(message);

//        print("datais " );
//        Navigator.of(context)
//            .push(MaterialPageRoute(builder: (context) => ReviewMain()));
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
      },
    );

    _firebaseMessaging.getToken().then((token) {
      print('token = ' + token);

      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((info) {
          //  homeBloc.postFirebaseToken(token, info.androidId);
        });
      } else {
        deviceInfo.iosInfo.then((info) {
          //   homeBloc.postFirebaseToken(token, info.identifierForVendor);
        });
      }
    });

    _firebaseMessaging.onTokenRefresh.listen((token) {
      print('token =  $token');
      final deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        deviceInfo.androidInfo.then((info) {
          //  homeBloc.updateFirebaseToken(token, info.androidId);
        });
      } else {
        deviceInfo.iosInfo.then((info) {
          //  homeBloc.updateFirebaseToken(token, info.identifierForVendor);
        });
      }
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.subscribeToTopic('allUsers');
  }

  showNotification(Map<String, dynamic> msg) async {
    var android = new AndroidNotificationDetails(
        "1", "Channel Name", "Channel description");
    var ios = new IOSNotificationDetails();
    var platform = new NotificationDetails(android, ios);
    print(msg['notification']['body']);
    await flutterLocalNotificationsPlugin.show(
        0,
        (msg['notification']['title']),
        (msg['notification']['body']),
        platform);
  }

  @override
  Widget build(BuildContext context) {
    // Router.present(WelcomeSceen(), context);
    initFireBase();
    return Scaffold(
        // appBar: AppBar(
        //   leading: Container(),
        //   elevation: 0.0,
        //   backgroundColor: Colors.transparent,
        //   actions: <Widget>[
        //     IconButton(
        //       color: Colors.black,
        //       icon: Container(
        //         constraints: BoxConstraints.expand(height: 30),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             Expanded(
        //               child: Container(
        //                 width: 100,
        //                 child: Text(
        //                   "العربية",
        //                   style: TextStyle(color: Colors.red),
        //                 ),
        //               ),
        //             ),
        //             Icon(Icons.language),
        //           ],
        //         ),
        //       ),
        //       onPressed: () {
        //         if (DataStore().getLocale().languageCode == 'en') {
        //           print('ar');
        //           DataStore().setLocale(Locale('ar', ''));
        //         } else {
        //           print('en');
        //           DataStore().setLocale(Locale('en', ''));
        //         }
        //         MyApp.setLocale(context, DataStore().getLocale());
        //       },
        //     ),
        //     if (DataStore().isUserLoggedIn)
        //       IconButton(
        //         icon: Icon(FontAwesomeIcons.userCircle,
        //             color: Colors.grey.shade900),
        //         onPressed: () {
        //           Router.present(ProfilePage(), context);
        //         },
        //       ),
        //   ],
        // ),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 40,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Container(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child:
                                (DataStore().getLocale().languageCode == 'en')
                                    ? Text(
                                        "العربية",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text("English",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Icon(Icons.language),
                      ],
                    ),
                  ),
                  onPressed: () {
                    if (DataStore().getLocale().languageCode == 'en') {
                      print('ar');
                      DataStore().setLocale(Locale('ar', ''));
                    } else {
                      print('en');
                      DataStore().setLocale(Locale('en', ''));
                    }
                    MyApp.setLocale(context, DataStore().getLocale());
                  },
                ),
                if (DataStore().isUserLoggedIn)
                  IconButton(
                    icon: Icon(FontAwesomeIcons.userCircle,
                        color: Colors.grey.shade900),
                    onPressed: () {
                      Router.present(ProfilePage(), context);
                    },
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment(1, 1),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: AppLocalizations.of(context).trans("welcome_msg"),
                        style: TextStyle(
                          color: Style.primaryDarkColor,
                          fontSize: 32.0,
                          fontFamily: "Verdana",
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(text: " "),
                          TextSpan(text: "K"),
                          TextSpan(
                            text: "I",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(text: "B")
                        ]),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LocalizedText(
                    "welcome_msg_sub_title",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: RadialMenu(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment(0, 0),
              child: LocalizedText(
                "rights_msg",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
