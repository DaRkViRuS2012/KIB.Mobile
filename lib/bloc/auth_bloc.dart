import 'dart:async';

import 'package:kib/bloc/bloc_provider.dart';
import 'package:kib/models/city.dart';
import 'package:kib/models/user.dart';
import 'package:kib/models/user_responce.dart';
import 'package:kib/network.dart';
import 'package:rxdart/rxdart.dart';

import '../validator.dart';

class AuthBloc extends BaseBloc with Validators, Network {
  bool shouldShowFeedBack;
  bool shouldNavgateToSignUp;

  AuthBloc(
      {this.shouldShowFeedBack = true, this.shouldNavgateToSignUp = false});

  final _emailLoginController = BehaviorSubject<String>();
  final _passwordLoginController = BehaviorSubject<String>();

  final _mobileSignUpController = BehaviorSubject<String>();
  final _passwordSignUpController = BehaviorSubject<String>();
  final _firstNameSignUpController = BehaviorSubject<String>();
  final _lastNameSignUpController = BehaviorSubject<String>();
  final _fatherNameSignUpController = BehaviorSubject<String>();
  final _userNameSignUpController = BehaviorSubject<String>();
  final _emailSignUpController = BehaviorSubject<String>();
  final _birthDateSignUpController = BehaviorSubject<String>();
  final _citySignUpController = BehaviorSubject<String>();
  final _selectedcitySignUpController = BehaviorSubject<City>();

  final _loadingController = BehaviorSubject<bool>();

  final _obscureLoginPasswordController = BehaviorSubject<bool>();

  final _obscureSignUpPassword = BehaviorSubject<bool>();
  final _obscureSignUpPasswordConfirmation = BehaviorSubject<bool>();

  final _submitLoginController = PublishSubject<UserResponse>();
  final _submitSignUpController = PublishSubject<UserResponse>();
  final _submitUpdateUserController = PublishSubject<User>();

  final _lockTouchEventController = BehaviorSubject<bool>();

  get pushLockTouchEvent => _lockTouchEventController.sink.add(true);

  get pushUnlockTouchEvent => _lockTouchEventController.sink.add(false);

  Function(String) get changeLoginEmail => _emailLoginController.sink.add;

  Function(String) get changeLoginPassword => _passwordLoginController.sink.add;
// signup
  Function(String) get changeSignUpMobile => _mobileSignUpController.sink.add;
  Function(String) get changeSignUpPassword =>
      _passwordSignUpController.sink.add;
  Function(String) get changeSignUpFirstName =>
      _firstNameSignUpController.sink.add;
  Function(String) get changeSignUpLastName =>
      _lastNameSignUpController.sink.add;
  Function(String) get changeSignUpFatherName =>
      _fatherNameSignUpController.sink.add;
  Function(String) get changeSignUpUserName =>
      _userNameSignUpController.sink.add;
  Function(String) get changeSignUpEmail => _emailSignUpController.sink.add;
  Function(String) get changeSignUpBirthDate =>
      _birthDateSignUpController.sink.add;
  Function(String) get changeSignUpCity => _citySignUpController.sink.add;
  Function(City) get changeSelectedSignUpCity =>
      _selectedcitySignUpController.sink.add;

  Stream<City> get selectedCityStream => _selectedcitySignUpController.stream;

  Stream<String> get mobileSignUpStream =>
      _mobileSignUpController.stream.transform(validateName);

  Stream<String> get firstNameSignUpStream =>
      _firstNameSignUpController.stream.transform(validateName);

  Stream<String> get passwordSignUpStream =>
      _passwordSignUpController.stream.transform(validatePassword);

  Stream<String> get emailSignUpStream =>
      _emailSignUpController.stream.transform(validateEmail);

  Stream<String> get fatherNameSignUpStream =>
      _fatherNameSignUpController.stream.transform(validateName);

  Stream<String> get lastNameSignUpStream =>
      _lastNameSignUpController.stream.transform(validateName);

  Stream<String> get userNameSignUpStream =>
      _userNameSignUpController.stream.transform(validateName);

  Stream<String> get citySignUpStream =>
      _citySignUpController.stream.transform(validateName);

  Stream<String> get birthDateSignUpStream =>
      _birthDateSignUpController.stream.transform(validateName);

  get pushObscureSignUpPassword =>
      _obscureSignUpPassword.sink.add(!_obscureSignUpPassword.value);

  Stream<bool> get obscureSignUpPasswordStream => _obscureSignUpPassword.stream;

  get pushObscureSignUpPasswordConfirmation =>
      _obscureSignUpPasswordConfirmation.sink
          .add(!_obscureSignUpPasswordConfirmation.value);

  Stream<bool> get obscureSignUpPasswordConfirmationStream =>
      _obscureSignUpPasswordConfirmation.stream;

  get pushObscureLoginPassword => _obscureLoginPasswordController.sink
      .add(!_obscureLoginPasswordController.value);

  Stream<bool> get obscureLoginPasswordStream =>
      _obscureLoginPasswordController.stream;

  Stream<String> get emailLoginStream =>
      _emailLoginController.stream.transform(validatePhone);

  Stream<String> get passwordLoginStream =>
      _passwordLoginController.stream.transform(validatePassword);

  Stream<bool> get submitValidLogin => Observable.combineLatest2(
      emailLoginStream, passwordLoginStream, (a, b) => true);

  Stream<bool> get submitValidSignUp => Observable.combineLatest8(
      mobileSignUpStream,
      firstNameSignUpStream,
      passwordSignUpStream,
      emailSignUpStream,
      fatherNameSignUpStream,
      lastNameSignUpStream,
      citySignUpStream,
      birthDateSignUpStream,
      (a, b, c, e, f, g, h, i) => true);

// _submitUpdateUserController
  Stream<UserResponse> get submitLoginStream => _submitLoginController.stream;

  Stream<UserResponse> get submitSignUpStream => _submitSignUpController.stream;

  Stream<User> get submitUpdteUserStream => _submitUpdateUserController.stream;

  Stream<bool> get lockTouchEventStream => _lockTouchEventController.stream;

  Stream<bool> get loadingStream => _loadingController.stream;

  get startLoading => _loadingController.sink.add(true);

  get stopLoading => _loadingController.sink.add(false);

  submitLogin() {
    final validEmail = _emailLoginController.value;
    final validPassword = _passwordLoginController.value;

    pushLockTouchEvent;
    startLoading;

    login(validEmail, validPassword).then((response) {
      print(response);
      _submitLoginController.sink.add(response);
      stopLoading;
    }).catchError((e) {
      shouldShowFeedBack = true;
      print(e);
      pushUnlockTouchEvent;
      _submitLoginController.sink.addError(e);
      stopLoading;
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        startLoading;
      });
    });
  }

  submitSignUp() {
    final validFirstName = _firstNameSignUpController.value;
    final validFatherName = _fatherNameSignUpController.value;
    final validLastName = _lastNameSignUpController.value;
    final validEmail = _emailSignUpController.value;
    // final validUserName = _userNameSignUpController.value;
    final validMobile = _mobileSignUpController.value;
    final validPassword = _passwordSignUpController.value;
    final validCityId = _citySignUpController.value;
    final validBirthDate = _birthDateSignUpController.value;
    pushLockTouchEvent;

    signUp(
      validFirstName,
      validFatherName,
      validLastName,
      validEmail,
      validMobile,
      validPassword,
      validBirthDate,
      validCityId,
    ).then((user) {
      login(validEmail, validPassword).then((response) {
        _submitSignUpController.sink.add(response);
        stopLoading;
        pushUnlockTouchEvent;
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      this.shouldShowFeedBack = true;
      stopLoading;
      pushUnlockTouchEvent;
      Future.delayed(Duration(milliseconds: 100)).then((_) {
        startLoading;
      });

      if (e == ErrorCodes.PHONENUMBER_OR_USERNAME_IS_USED) {
        _submitSignUpController.sink
            .addError("PHONENUMBER_OR_USERNAME_IS_USED");
      } else {
        _submitSignUpController.sink.addError(
            "Please check your data Mobile should only be 9 digits with out 0");
      }
      print(e);
    });
  }

  dispose() {
    _mobileSignUpController.close();
    _passwordSignUpController.close();
    _firstNameSignUpController.close();
    _lastNameSignUpController.close();
    _fatherNameSignUpController.close();
    _userNameSignUpController.close();
    _emailSignUpController.close();
    _birthDateSignUpController.close();
    _citySignUpController.close();
    _emailLoginController.close();
    _passwordLoginController.close();
    _submitLoginController.close();
    _submitSignUpController.close();
    _submitUpdateUserController.close();
    _loadingController.close();
    _obscureLoginPasswordController.close();
    _obscureSignUpPassword.close();
    _obscureSignUpPasswordConfirmation.close();
    _lockTouchEventController.close();
    _selectedcitySignUpController.close();
  }
}
