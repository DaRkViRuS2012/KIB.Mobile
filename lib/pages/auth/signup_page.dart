import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kib/bloc/appBloc.dart';
import 'package:kib/bloc/auth_bloc.dart';
import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/common_widgets/feedback.dart';
import 'package:kib/common_widgets/localized_text.dart';
import 'package:kib/common_widgets/main_button.dart';
import 'package:kib/models/city.dart';
import 'package:kib/models/city_response.dart';
import 'package:kib/models/user_responce.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../localization.dart';

class SignUpPage extends StatefulWidget {
  @override
  SignUpPageState createState() {
    return new SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> with UserFeedback {
  final FocusNode myFocusNodeFirstName = FocusNode();

  final FocusNode myFocusNodeFatherName = FocusNode();

  final FocusNode myFocusNodeLastName = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();

  final FocusNode myFocusNodeEmail = FocusNode();

  final FocusNode myFocusNodeUsername = FocusNode();
  final FocusNode myFocusNodeMobile = FocusNode();

  final TextEditingController signupEmailController =
      new TextEditingController();

  final TextEditingController signupFirstNameController =
      new TextEditingController();

  final TextEditingController signupPasswordController =
      new TextEditingController();

  final TextEditingController signupLastNameController =
      new TextEditingController();

  final TextEditingController signupFatherNameController =
      new TextEditingController();

  final TextEditingController signupMobileController =
      new TextEditingController();

  final TextEditingController signupUserNameController =
      new TextEditingController();
  AppBloc appBloc;
  AuthBloc bloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    bloc = AuthBloc();
    appBloc.citis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appBloc.citis();
    return Material(
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Container(
              child: StreamBuilder<UserResponse>(
                  stream: bloc.submitSignUpStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError && bloc.shouldShowFeedBack) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showInSnackBar(snapshot.error.toString(), context,
                            color: Colors.redAccent);
                      });
                      bloc.shouldShowFeedBack = false;
                    }
                    if (snapshot.hasData) {
                      appBloc.saveUser(snapshot.data.user);
                      appBloc.saveToken("${snapshot.data.user.token}");
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        // Navigator.of(context).pushReplacement(new MaterialPageRoute(
                        //     builder: (context) => HomePage(
                        //           afterLogin: true,
                        //         )));
                        // Router.push(CodePage(), context);
                        launch("http://khouryinsurance.com/user/active");
                      });
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          elevation: 2.0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                nameTextField(),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                middelNameTextField(),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                lastNameTextField(),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),

                                emailTextField(),
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
                                passwordTextField(),

                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                _startDate(),
                                Container(
                                  width: 250.0,
                                  height: 1.0,
                                  color: Colors.grey[400],
                                ),
                                cityTextField(),

                                // isoCodePicker(),
                              ],
                            ),
                          ),
                        ),
                        signUpBtn(),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Widget nameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeFirstName,
        controller: signupFirstNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpFirstName,
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
          hintText: AppLocalizations.of(context).trans('name'),
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget userNameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeUsername,
        controller: signupUserNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpUserName,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.black,
          ),
          hintText: AppLocalizations.of(context).trans('username'),
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget middelNameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeFatherName,
        controller: signupFatherNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpFatherName,
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
          hintText: AppLocalizations.of(context).trans('fathername'),
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget lastNameTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
      child: TextField(
        focusNode: myFocusNodeLastName,
        controller: signupLastNameController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpLastName,
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
          hintText: AppLocalizations.of(context).trans('lastname'),
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
        focusNode: myFocusNodeEmail,
        controller: signupEmailController,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        onChanged: bloc.changeSignUpEmail,
        style: TextStyle(
            fontFamily: "WorkSansSemiBold",
            fontSize: 16.0,
            color: Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(
            Icons.email,
            color: Colors.black,
          ),
          hintText: AppLocalizations.of(context).trans('email'),
          hintStyle: TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
        ),
      ),
    );
  }

  Widget cityTextField() {
    return Padding(
      padding:
          EdgeInsets.only(top: 20.0, bottom: 20.0, left: 64.0, right: 64.0),
      child: StreamBuilder<CityResponce>(
          stream: appBloc.citiesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DropdownButton<City>(
                isExpanded: true,
                items: snapshot.data.data.map((city) {
                  return DropdownMenuItem<City>(
                    child: Container(
                      // color: Colors.white,
                      // width: MediaQuery.of(context)
                      //         .size
                      //         .width /
                      //     1.5,
                      constraints: BoxConstraints.expand(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            city.title(AppLocalizations.of(context).locale)),
                      ),
                    ),
                    value: city, //"${service.id}",
                  );
                }).toList(),
                onChanged: (c) {
                  print(c.enTitle);
                  bloc.changeSignUpCity("${c.id}");
                },
                value: snapshot.hasData
                    ? snapshot.data.data[0]
                    : null, //"${snapshot.data.data[0].id}",
                hint: LocalizedText(
                  "city",
                ),
              );
            }
            return Container();
          }),
    );
  }

  Widget phoneTextField() {
    return StreamBuilder<String>(
        stream: bloc.mobileSignUpStream,
        builder: (context, phoneSnapshot) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
            child: TextField(
              focusNode: myFocusNodeMobile,
              controller: signupMobileController,
              keyboardType: TextInputType.phone,
              onChanged: bloc.changeSignUpMobile,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.black),
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                errorText:
                    AppLocalizations.of(context).trans(phoneSnapshot.error),
                errorStyle: TextStyle(height: 0.1),
                // prefixText: snapshot.data.dialCode,
                border: InputBorder.none,
                icon: Icon(
                  FontAwesomeIcons.mobile,
                  color: Colors.black,
                ),
                hintText: AppLocalizations.of(context).trans('mobile'),
              ),
            ),
          );
        });
  }

  Widget passwordTextField() {
    return StreamBuilder<bool>(
      stream: bloc.obscureSignUpPasswordStream,
      builder: (context, snapshot) {
        return Padding(
          padding:
              EdgeInsets.only(top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
          child: TextField(
            focusNode: myFocusNodePassword,
            controller: signupPasswordController,
            obscureText: snapshot.data ?? true,
            onChanged: bloc.changeSignUpPassword,
            style: TextStyle(
                fontFamily: "WorkSansSemiBold",
                fontSize: 16.0,
                color: Colors.black),
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                FontAwesomeIcons.lock,
                color: Colors.black,
              ),
              hintText: AppLocalizations.of(context).trans('password'),
              hintStyle:
                  TextStyle(fontFamily: "WorkSansSemiBold", fontSize: 16.0),
              suffixIcon: GestureDetector(
                onTap: () => bloc.pushObscureSignUpPassword,
                child: Icon(
                  FontAwesomeIcons.eye,
                  size: 15.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget signUpBtn() {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: StreamBuilder<bool>(
        stream: bloc.submitValidSignUp,
        initialData: false,
        builder: (context, snapshot) {
          return StreamBuilder<bool>(
              stream: bloc.loadingStream,
              initialData: true,
              builder: (context, loadingSnapshot) {
                return MainButton(
                  text: AppLocalizations.of(context).trans('submit'),
                  onPressed: () {
                    if ((!snapshot.hasData || !snapshot.data)) {
                      showInSnackBar('error_provide_valid_info_signup', context,
                          color: Colors.redAccent);
                      bloc.shouldShowFeedBack = false;
                    } else
                      bloc.submitSignUp();
                  },
                  loading: (snapshot.data == null ? false : snapshot.data) &&
                      loadingSnapshot.data,
                );
              });
        },
      ),
    );
  }

  _startDate() {
    return StreamBuilder<String>(
        stream: bloc.birthDateSignUpStream,
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment(-1, 0),
            padding: EdgeInsetsDirectional.only(
                top: 20.0, bottom: 20.0, start: 46.0, end: 25.0),
            child: FlatButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 3, 5),
                      maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    bloc.changeSignUpBirthDate(
                        "${date.year}-${date.month}-${date.day}");
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: Text(
                    snapshot.hasData ? snapshot.data : 'BirthDate',
                    textAlign: TextAlign.start,
                  ),
                )),
          );
        });
  }
}
