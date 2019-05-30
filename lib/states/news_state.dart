// The State represents the data the View requires. The View consumes a Stream
// of States. The view rebuilds every time the Stream emits a new State!
//
// The State Stream will emit new States depending on the situation: The
// initial state, loading states, the list of results, and any errors that
// happen.
//
// The State Stream responds to input from the View by accepting a
// Stream<String>. We call this Stream the onTextChanged "intent".

import 'package:kib/models/news.dart';

class NewsState {
  NewsState();
}

class NewsLoading extends NewsState {}

class NewsError extends NewsState {
  final String error;
  NewsError(this.error);
}

class NewsNoResults extends NewsState {}

class NewsPopulated extends NewsState {
  List<News> news;

  update({List<News> newNews}) {
    this..news = [];

    return this..news.addAll(newNews ?? this.news);
  }

  NewsPopulated(this.news);
}

class NewsEmpty extends NewsState {}
