// The State represents the data the View requires. The View consumes a Stream
// of States. The view rebuilds every time the Stream emits a new State!
//
// The State Stream will emit new States depending on the situation: The
// initial state, loading states, the list of results, and any errors that
// happen.
//
// The State Stream responds to input from the View by accepting a
// Stream<String>. We call this Stream the onTextChanged "intent".

import 'package:kib/models/service.dart';

class ServicesState {
  ServicesState();
}

class ServicesLoading extends ServicesState {}

class ServicesError extends ServicesState {
  final String error;
  ServicesError(this.error);
}

class ServicesNoResults extends ServicesState {}

class ServicesPopulated extends ServicesState {
  final List<Service> services;

  update({List<Service> newServices}) {
    return this..services.addAll(newServices ?? this.services);
  }

  ServicesPopulated(this.services);
}

class ServicesEmpty extends ServicesState {}
