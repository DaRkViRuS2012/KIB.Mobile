import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/auth_bloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/feedback.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/main_button.dart';
import 'package:kib/common_widgets/router.dart';
import 'package:kib/models/user_responce.dart';
import 'package:kib/pages/auth/code_page.dart';
import 'package:kib/pages/auth/signup_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> with UserFeedback {
  final FocusNode myFocusNodeEmailLogin = FocusNode();

  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();

  TextEditingController loginPasswordController = new TextEditingController();

  AuthBloc bloc;
  AppBloc appBloc;

  @override
  void initState() {
    bloc = AuthBloc();
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: new InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<UserResponse>(
              // feedback the user about the server response.
              stream: bloc.submitLoginStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  appBloc.saveUser(snapshot.data.user);
                  appBloc.saveToken("${snapshot.data.user.token}");
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop();
                  });
                }
                if (snapshot.hasError && bloc.shouldShowFeedBack) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    bloc.shouldShowFeedBack = false;
                    print(snapshot.error.toString());
                    showInSnackBar(snapshot.error.toString(), context,
                        color: Colors.redAccent);
                  });
                }
                return Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Logo.png'))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Card(
                            elevation: 2.0,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              width: 300.0,
                              height: 180.0,
                              child: Column(
                                children: <Widget>[
                                  phoneTextField(),
                                  Container(
                                    width: 250.0,
                                    height: 1.0,
                                    color: Colors.grey[400],
                                  ),
                                  passwordTextField(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: loginBtn(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: registerButton(),
                      ),
                      codeButton(),
                      resetButton()
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
      stream: bloc.emailLoginStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 8.0, left: 25.0, right: 25.0),
          child: Container(
            height: 60,
            child: TextField(
              focusNode: myFocusNodeEmailLogin,
              controller: loginEmailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: bloc.changeLoginEmail,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                errorText: AppLocalizations.of(context).trans(snapshot.error),
                errorStyle: TextStyle(height: 0.1, fontSize: 12),
                hintText: AppLocalizations.of(context).trans('email'),
                hintStyle:
                    TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 17.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget passwordTextField() {
    return StreamBuilder<String>(
      stream: bloc.passwordLoginStream,
      builder: (context, passwordSnapshot) {
        return StreamBuilder<bool>(
          initialData: true,
          stream: bloc.obscureLoginPasswordStream,
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 25.0, right: 25.0),
              child: Container(
                height: 60,
                child: TextField(
                  focusNode: myFocusNodePasswordLogin,
                  controller: loginPasswordController,
                  obscureText: snapshot.data,
                  onChanged: bloc.changeLoginPassword,
                  style: TextStyle(
                      fontFamily: "WorkSansSemiBold",
                      fontSize: 16.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      FontAwesomeIcons.lock,
                      size: 22.0,
                      color: Colors.black,
                    ),
                    errorText: AppLocalizations.of(context)
                        .trans(passwordSnapshot.error),
                    hintText: AppLocalizations.of(context).trans('password'),
                    hintStyle: TextStyle(
                        fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                    suffixIcon: GestureDetector(
                      onTap: () => bloc.pushObscureLoginPassword,
                      child: Icon(
                        FontAwesomeIcons.eye,
                        size: 15.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget loginBtn() {
    return StreamBuilder<bool>(
      stream: bloc.submitValidLogin,
      initialData: false,
      builder: (context, snapshot) {
        return StreamBuilder<bool>(
            stream: bloc.loadingStream,
            initialData: true,
            builder: (context, loadingSnapshot) {
              return MainButton(
                text: AppLocalizations.of(context).trans('login'),
                onPressed: () {
                  if ((!snapshot.hasData || !snapshot.data)) {
                    showInSnackBar('error_provide_valid_info', context,
                        color: Colors.redAccent);
                    bloc.shouldShowFeedBack = false;
                  } else
                    bloc.submitLogin();
                },
                width: 150,
                height: 50,
                loading: (snapshot.data == null ? false : snapshot.data) &&
                    loadingSnapshot.data,
              );
            });
      },
    );
  }

  Widget registerButton() {
    return FlatButton(
        onPressed: () {
          print("pressed");
          Router.push(SignUpPage(), context);
        },
        child: LocalizedText("register_btn_title"));
  }

  Widget codeButton() {
    return FlatButton(
        onPressed: () {
          print("pressed");
          Router.navigateTo(CodePage(), context);
          // launch("http://khouryinsurance.com/user/active");
        },
        child: LocalizedText("code_activate"));
  }

  Widget resetButton() {
    return FlatButton(
        onPressed: () {
          print("pressed");
          launch("http://khouryinsurance.com/password/reset");
        },
        child: LocalizedText("rest_password"));
  }
}
