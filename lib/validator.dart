import 'dart:async';

mixin Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('error_valid_email');
    }
  });

  final validatePhone = StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNumber, sink) {
    if (phoneNumber.length >= 5 && !phoneNumber.startsWith('0')) {
      sink.add(phoneNumber);
    } else {
      if (phoneNumber.length < 5)
        sink.addError('error_valid_phone_number');
      else if (phoneNumber.startsWith('0'))
        sink.addError('error_international_phone_number');
    }
  });

  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.length >= 0) {
      sink.add(name);
    } else {
      sink.addError('error_valid_name');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 5) {
      sink.add(password);
    } else {
      sink.addError('error_valid_password');
    }
  });

  final authCheck =
      StreamTransformer<bool, bool>.fromHandlers(handleData: (auth, sink) {
    if (auth == true) {
      sink.add(true);
    } else {
      sink.add(false);
      sink.addError('Must be Authenticated');
    }
  });
}
