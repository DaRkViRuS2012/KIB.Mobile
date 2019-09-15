import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/auth_bloc.dart';
import 'package:kib/common_widgets/feedback.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/main_button.dart';
import 'package:kib/common_widgets/styles.dart';
import 'package:kib/dataStore/dataStore.dart';

import '../../localization.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() {
    return new ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> with UserFeedback {
  final FocusNode myFocusNodePassword = FocusNode();

  final FocusNode myFocusNodeEmail = FocusNode();

  final FocusNode myFocusNodeName = FocusNode();

  final TextEditingController signupEmailController =
      new TextEditingController();

  final TextEditingController signupNameController =
      new TextEditingController();

  final TextEditingController signupPasswordController =
      new TextEditingController();

  final TextEditingController signupConfirmPasswordController =
      new TextEditingController();
  AppBloc appBloc;
  AuthBloc bloc;
  String userId;
  String token;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    signupNameController.text = DataStore().me.name;
    signupPasswordController.text = DataStore().me.mobile;
    signupEmailController.text = DataStore().me.email;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: new LocalizedText(
            "profile",
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
        ),
        body: Stack(children: <Widget>[
          containerView(),
        ]),
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: signupNameController,
        enabled: false,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.user,
            color: Colors.black,
          ),
          hintText: "Name",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: signupPasswordController,
        enabled: false,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.mobile,
            color: Colors.black,
          ),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget emailTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        controller: signupEmailController,
        enabled: false,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.mail,
            color: Colors.black,
          ),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget signUpBtn() {
    return Container(
        // margin: EdgeInsets.only(top: 120),
        child: MainButton(
      text: AppLocalizations.of(context).trans("logout"),
      onPressed: () {
        DataStore().logout;
        Navigator.of(context).pop();
      },
      width: 150,
      height: 50,
    ));
  }

  containerView() {
    return Container(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 150.0, left: 0, right: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  // margin: EdgeInsets.only(top: 60.0),
                  height: 330.0,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [Style.shadow],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Container(
                  // RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(8.0),
                  // ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300.0,
                        height: 360.0,
                        child: Column(
                          children: <Widget>[
                            nameTextField(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            phoneTextField(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            emailTextField(),
                            // passwordTextField(),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            signUpBtn(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
