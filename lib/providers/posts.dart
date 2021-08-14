import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/models/post.dart';
// import 'package:instagram_ui_clone/models/http_exception.dart';
// import 'package:instagram_ui_clone/models/post.dart';

class Posts with ChangeNotifier {
  // final List<Post> _posts = [];
  // bool isLoading = false;
  // bool noFollowing = false;

  List<dynamic> queryList;

  Future<void> fetchFollowingData() async {
    final userFollowingData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    final List<dynamic> followingList = userFollowingData.data()['following'];
    print(followingList);
    queryList = followingList.map((e) {
      return FirebaseFirestore.instance.doc('users/$e/');
    }).toList();
  }

  List<Post> setViva(List<QueryDocumentSnapshot> documents) {
    List<Post> availablePosts = [];

    documents.forEach((doc) {
      availablePosts.add(Post(
        postUrl: doc['imageUrl'],
        location: doc['location'],
        caption: doc['caption'],
        date: DateTime.parse(doc['timeStamp'].toDate().toString()),
        addedBy: doc['addedBy'],
        docId: doc.id,
        likedBy: doc['likedBy'],
      ));
    });
    return availablePosts..sort((a, b) => b.date.compareTo(a.date));
  }

  // List<Post> get posts {
  //   // if (_posts.isEmpty) {
  //   //   try {
  //   //     fetchAndSetPosts().then((_) {
  //   //       return _posts..sort((a, b) => b.date.compareTo(a.date));
  //   //     });
  //   //   } on HttpException catch (error) {
  //   //     print("Emror aa gaya 2");
  //   //   }
  //   // }
  //   // return _posts..sort((a, b) => b.date.compareTo(a.date));

  //   try {
  //     if (_posts.isEmpty) {
  //       fetchAndSetPosts().then((_) {
  //         return _posts..sort((a, b) => b.date.compareTo(a.date));
  //       });
  //     }
  //     return _posts..sort((a, b) => b.date.compareTo(a.date));
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  // Future<void> fetchAndSetPosts() async {
  //   try {
  //     final userFollowingData = await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser.uid)
  //         .get();
  //     final List<dynamic> followingList = userFollowingData.data()['following'];
  //     print(followingList);
  //     final queryList = followingList.map((e) {
  //       return FirebaseFirestore.instance.doc('users/$e/');
  //     }).toList();
  //     // followingList.forEach((element) {
  //     //   element = FirebaseFirestore.instance.doc('users/$element/');
  //     // });

  //     if (queryList.isEmpty) {
  //       noFollowing = true;
  //       notifyListeners();
  //     } else {
  //       noFollowing = false;
  //       notifyListeners();
  //     }

  //     _posts.clear();
  //     final response = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .where('addedBy', whereIn: queryList)
  //         // .where('addedBy',
  //         //     isNotEqualTo: FirebaseFirestore.instance
  //         //         .doc('/users/${FirebaseAuth.instance.currentUser.uid}'))
  //         .get();
  //     response.docs.forEach((doc) {
  //       _posts.add(
  //         Post(
  //           postUrl: doc['imageUrl'],
  //           location: doc['location'],
  //           caption: doc['caption'],
  //           date: DateTime.parse(doc['timeStamp'].toDate().toString()),
  //           addedBy: doc['addedBy'],
  //           likedBy: doc['likedBy'],
  //           docId: doc.id,
  //         ),
  //       );
  //     });
  //   } catch (error) {
  //     throw error;
  //   }
  //   notifyListeners();
  // }
}
