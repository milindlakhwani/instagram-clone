import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/models/post.dart';

class Posts with ChangeNotifier {
  final List<Post> _posts = [];
  bool isLoading = false;

  List<Post> get posts {
    if (_posts.isEmpty) {
      fetchAndSetPosts().then((_) {
        return _posts..sort((a, b) => b.date.compareTo(a.date));
      });
    }
    return _posts..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> fetchAndSetPosts() async {
    try {
      final response = await FirebaseFirestore.instance
          .collection('posts')
          .where('addedBy',
              isNotEqualTo: FirebaseFirestore.instance
                  .doc('/users/${FirebaseAuth.instance.currentUser.uid}'))
          .get();
      _posts.clear();
      response.docs.forEach((doc) {
        _posts.add(Post(
            postUrl: doc['imageUrl'],
            location: doc['location'],
            caption: doc['caption'],
            date: DateTime.parse(doc['timeStamp'].toDate().toString()),
            addedBy: doc['addedBy']));
      });
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }
}















// Future<void> fetchPosts() async {
  //   try {
  //     final response = await FirebaseFirestore.instance
  //         .collection('posts')
  //         .where('addedBy', isNotEqualTo: _auth.currentUser.displayName)
  //         .get();
  //     _posts.clear();
  //     response.docs.forEach((doc) {
  //       _posts.add(Post(
  //         postUrl: doc['imageUrl'],
  //         location: doc['location'],
  //         caption: doc['caption'],
  //         date: DateTime.parse(doc['timeStamp'].toDate().toString()),
  //         name: doc['addedBy'],
  //         profileUrl: doc['profileUrl'],
  //       ));
  //     });
  //   } catch (error) {
  //     throw error;
  //   }

  //   // final allPosts = FirebaseFirestore.instance
  //   //     .collection('posts')
  //   //     .where('addedBy', isNotEqualTo: _auth.currentUser.displayName);
  //   // try {
  //   //   allPosts.get().then((QuerySnapshot querySnapshot) {
  //   //     querySnapshot.docs.forEach((doc) {
  //   //       _posts.add(Post(
  //   //         postUrl: doc['imageUrl'],
  //   //         location: doc['location'],
  //   //         caption: doc['caption'],
  //   //         date: DateTime.parse(doc['timeStamp'].toDate().toString()),
  //   //         name: doc['addedBy'],
  //   //         profileUrl: doc['profileUrl'],
  //   //       ));
  //   //     });
  //   //   });
  //   // } catch (error) {
  //   //   print(error);
  //   // }
  // }

  // Future<void> oneTimeFetch() async {
  //   await fetchPosts();
  // }