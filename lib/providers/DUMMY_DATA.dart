import 'package:instagram_ui_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/widgets/dm_widget.dart';
// import 'package:instagram_ui_clone/screens/search.dart';

import '../models/post.dart';
import '../models/story.dart';

class DummyData {
  final tab = TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(Icons.arrow_forward)),
    new Tab(icon: new Icon(Icons.arrow_downward)),
    new Tab(icon: new Icon(Icons.arrow_back)),
  ]);

  User get currentUser {
    return User(
      displayname: "User Name",
      imageUrl: "assets/images/img.png",
      userName: "user_name_1999",
      postNum: 5,
      followers: 1024,
      following: 102,
      bio: "Bio line 1 \nBio Line 2",
      userPosts: List.generate(10, (index) => "assets/images/img.png"),
    );
  }

  final List<Post> posts = [
    Post(
      name: "test_name",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      date: "September 19",
      likedby: List.generate(
          10,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
    ),
    Post(
      name: "test_name_1",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      date: "September 19",
      likedby: List.generate(
          15,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
    ),
    Post(
      name: "test_name_2",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      date: "September 19",
      likedby: List.generate(
          20,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
    ),
    Post(
      name: "test_name_3",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      date: "September 19",
      likedby: List.generate(
          5,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
    ),
    Post(
      name: "test_name_4",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      date: "September 19",
      likedby: List.generate(
          3,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
    ),
    Post(
      name: "test_name_5",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          13,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_6",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          30,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_7",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          45,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_8",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          18,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_9",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          21,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_10",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          36,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
    Post(
      name: "test_name_11",
      caption: "A sample picture",
      location: "Tokyo, Japan",
      postUrl: "assets/images/img.png",
      profileUrl: "assets/images/img.png",
      likedby: List.generate(
          50,
          (index) => User(
              userName: "user_num_$index", imageUrl: "assets/images/img.png")),
      date: "September 19",
    ),
  ];

  // final List<User> users = [
  //   User("Person 1", imageUrl)
  // ]

  final List<Story> stories = [
    Story(
      userName: "Your Story",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Your Story",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 1",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 2",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 3",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 4",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 5",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 6",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 7",
      imageUrl: "assets/images/img.png",
    ),
    Story(
      userName: "Person 8",
      imageUrl: "assets/images/img.png",
    ),
  ];

  final List<String> searchImages =
      List.generate(100, (index) => "assets/images/img.png");

  final List<Widget> chatWidgets = [
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 1",
      chatDetail: "This is a test chamt",
      time: "now",
      ringEnabled: true,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 2",
      chatDetail: "Instagram UI",
      time: "5min",
      ringEnabled: false,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 3",
      chatDetail: "Let's Catch up tommorrow",
      time: "10min",
      ringEnabled: false,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 4",
      chatDetail: "Hey! How you're doin.",
      time: "15min",
      ringEnabled: false,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 5",
      chatDetail: "Fuck You",
      time: "20min",
      ringEnabled: true,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 6",
      chatDetail: "You deserve someone better",
      time: "25min",
      ringEnabled: false,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 7",
      chatDetail: "Tumhe to koi bhi mil jayegi",
      time: "30min",
      ringEnabled: true,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 8",
      chatDetail: "Waah bhaimya fullmon flutter baamzi",
      time: "30min",
      ringEnabled: true,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 9",
      chatDetail: "Instagram UI",
      time: "31min",
      ringEnabled: false,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 10",
      chatDetail: "Instagram UI",
      time: "40min",
      ringEnabled: true,
    ),
    ChatBox(
      chatImage: "assets/images/img.png",
      chatName: "Person 11",
      chatDetail: "Instagram UI",
      time: "45min",
      ringEnabled: false,
    ),
  ];
}
