import 'package:flutter/foundation.dart';

class Post {
  final String postUrl;
  final String location;
  final String caption;
  final DateTime date;
  final String name;
  final String profileUrl;

  Post({
    @required this.postUrl,
    @required this.location,
    @required this.caption,
    @required this.date,
    @required this.name,
    @required this.profileUrl,
  });
  // final String profileUrl;
  // final String postUrl;
  // final String location;
  // final String name;
  // final String caption;
  // final String date;
  // final List<User> likedby;

  // Post({
  //   @required this.profileUrl,
  //   @required this.postUrl,
  //   @required this.location,
  //   @required this.name,
  //   @required this.caption,
  //   @required this.date,
  //   @required this.likedby,
  // });
}
