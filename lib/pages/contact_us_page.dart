import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kib/common_widgets/common_widgets.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusPage extends StatefulWidget {
  ContactusPage({Key key}) : super(key: key);

  _ContactusPageState createState() => _ContactusPageState();
}

class _ContactusPageState extends State<ContactusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: "contant_us_title", context: context),
      body: Material(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                    alignment: Alignment(0, 0),
                    margin: EdgeInsets.all(8.0),
                    constraints: BoxConstraints.expand(height: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Logo.png'),
                        ),
                      ),
                    )),
                Container(
                  alignment: Alignment(0, 0),
                  child: LocalizedText('contact_us_info',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  margin: EdgeInsets.all(8.0),
                  constraints: BoxConstraints.expand(height: 150),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   boxShadow: [Style.shadow],
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  constraints: BoxConstraints.expand(height: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          sendMail("I have a Complaint");
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment(0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [Style.shadow],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: ListTile(
                            title: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/inquiry.png')))),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LocalizedText(
                                "inquiry",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          sendMail("I have an Inquiry");
                        },
                        child: Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment(0, 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [Style.shadow],
                              borderRadius: BorderRadius.circular(5.0)),
                          child: ListTile(
                            title: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/complaint.png')))),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: LocalizedText(
                                "complaint",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.all(16.0),
                  child: LocalizedText(
                    "contanct_socail",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  constraints: BoxConstraints.expand(height: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          launch("tel:+963969876543");
                        },
                        icon: Icon(
                          Icons.phone,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          launch("http://khouryinsurance.com");
                        },
                        icon: Icon(
                          FontAwesomeIcons.wordpress,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          launch("http://khouryinsurance.com");
                        },
                        icon: Icon(
                          FontAwesomeIcons.facebookF,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment(0, 0),
                  child: LocalizedText(
                    "rights_msg",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sendMail(String subject) {
    launch(
        'mailto:<khourybrokerage@gmail.com>?subject=' + '$subject' + '&body=');
  }
}
