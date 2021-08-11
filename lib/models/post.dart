import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Post {
  final String postUrl;
  final String location;
  final String caption;
  final DateTime date;
  final String docId;
  // final String name;
  // final String profileUrl;
  final DocumentReference addedBy;
  final List likedBy;

  Post({
    @required this.postUrl,
    @required this.location,
    @required this.caption,
    @required this.date,
    // @required this.name,
    // @required this.profileUrl,
    @required this.addedBy,
    @required this.docId,
    @required this.likedBy,
  });
}
