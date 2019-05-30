// The State represents the data the View requires. The View consumes a Stream
// of States. The view rebuilds every time the Stream emits a new State!
//
// The State Stream will emit new States depending on the situation: The
// initial state, loading states, the list of results, and any errors that
// happen.
//
// The State Stream responds to input from the View by accepting a
// Stream<String>. We call this Stream the onTextChanged "intent".

import 'package:kib/models/gallery.dart';

class GalleryState {
  GalleryState();
}

class GalleryLoading extends GalleryState {}

class GalleryError extends GalleryState {
  final String error;
  GalleryError(this.error);
}

class GalleryNoResults extends GalleryState {}

class GalleryPopulated extends GalleryState {
  List<Gallery> galleries;

  update({List<Gallery> newGalleries}) {
    this..galleries = [];

    return this..galleries.addAll(newGalleries ?? this.galleries);
  }

  GalleryPopulated(this.galleries);
}

class GalleryEmpty extends GalleryState {}
