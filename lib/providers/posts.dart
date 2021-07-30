import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram_ui_clone/models/post.dart';

class Posts with ChangeNotifier {
  bool isInit = true;
  final _auth = FirebaseAuth.instance;
  final List<Post> _posts = [];

  List<Post> get posts {
    print(_posts);
    return _posts..sort((a, b) => a.date.compareTo(b.date));
  }

  void fetchAndSetPosts() {
    final allPosts = FirebaseFirestore.instance
        .collection('posts')
        .where('addedBy', isNotEqualTo: _auth.currentUser.uid);
    try {
      allPosts.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          _posts.add(Post(
            postUrl: doc['imageUrl'],
            location: doc['location'],
            caption: doc['caption'],
            date: DateTime.parse(doc['timeStamp'].toDate().toString()),
            name: doc['addedBy'],
            profileUrl: doc['profileUrl'],
          ));
        });
      });
    } catch (error) {
      print(error);
    }

    if (isInit) {
      isInit = false;
    } else {
      notifyListeners();
    }
  }

  // Future<Map<String, String>> userDetails(Post post) async {
  //   Map<String, String> map;
  //   final user =
  //       FirebaseFirestore.instance.collection('users').doc(post.addedBy);
  //   final response = await user.get();
  //   final data = response.data();
  //   map = {
  //     'name': data['user_name'],
  //     'profileUrl': data['imageUrl'],
  //   };
  //   return map;
  // }
}
