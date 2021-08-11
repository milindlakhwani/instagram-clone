import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';

class UserPost extends StatefulWidget {
  final Post post;
  const UserPost(this.post);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  String profileUrl;
  String name;
  bool isLoading = true;
  final _auth = FirebaseAuth.instance;
  bool isLiked;
  final CollectionReference _db =
      FirebaseFirestore.instance.collection('posts');

  @override
  void initState() {
    isLiked = widget.post.likedBy
        .contains(FirebaseAuth.instance.currentUser.displayName);
    widget.post.addedBy.get().then((response) {
      final data = response.data() as Map<String, dynamic>;
      profileUrl = data['imageUrl'];
      name = data['user_name'];
      setState(() {
        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: SizeConfig.horizontalBlockSize * 6,
                      backgroundImage: NetworkImage(profileUrl ??
                          "https://i2.wp.com/wilkinsonschool.org/wp-content/uploads/2018/10/user-default-grey.png"),
                    ),
                    MySpaces.hGapInBetween,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: MyFonts.medium.size(16),
                        ),
                        MySpaces.vSmallestGapInBetween,
                        Text(widget.post.location),
                      ],
                    ),
                  ],
                ),
              ),
              Image.network(
                widget.post.postUrl,
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          IconButton(
                            iconSize: SizeConfig.horizontalBlockSize * 8,
                            onPressed: () async {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              try {
                                setState(() {
                                  isLiked = !isLiked;
                                });
                                isLiked
                                    ? await _db.doc(widget.post.docId).update({
                                        'likedBy': widget.post.likedBy
                                          ..insert(
                                              0, _auth.currentUser.displayName)
                                      })
                                    : await _db.doc(widget.post.docId).update({
                                        'likedBy': widget.post.likedBy
                                          ..remove(
                                              _auth.currentUser.displayName)
                                      });
                              } catch (error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: kBlack,
                                    content: Text(
                                      "Unable to like the post",
                                      style: MyFonts.light
                                          .setColor(kWhite)
                                          .size(15),
                                    ),
                                  ),
                                );
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: kBlack,
                                  content: Text(
                                    "You have ${isLiked ? "liked" : "disliked"} the post",
                                    style:
                                        MyFonts.light.setColor(kWhite).size(15),
                                  ),
                                ),
                              );
                            },
                            icon: isLiked
                                ? Icon(Icons.favorite_rounded,
                                    color: Colors.red)
                                : Icon(Icons.favorite_outline),
                          ),
                          MySpaces.hGapInBetween,
                          Icon(
                            FontAwesomeIcons.comment,
                            size: SizeConfig.horizontalBlockSize * 8,
                          ),
                          MySpaces.hSmallGapInBetween,
                          Icon(
                            FontAwesomeIcons.paperPlane,
                            size: SizeConfig.horizontalBlockSize * 7,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (widget.post.likedBy.isNotEmpty)
                          Text((widget.post.likedBy.length == 1)
                              ? "Liked by ${widget.post.likedBy[0]}"
                              : "Liked by ${widget.post.likedBy[0]} and ${widget.post.likedBy.length - 1} others"),
                      ],
                    ),
                    MySpaces.vSmallestGapInBetween,
                    RichText(
                      text: TextSpan(
                          text: name + " ",
                          // text: widget.post.name + " ",
                          style: MyFonts.medium
                              .size(SizeConfig.textScaleFactor * 17),
                          children: [
                            TextSpan(
                                text: widget.post.caption,
                                style: MyFonts.light
                                    .size(SizeConfig.textScaleFactor * 15))
                          ]),
                    ),
                    MySpaces.vGapInBetween,
                    Text(
                      DateFormat('MMMM dd , yy').format(widget.post.date),
                      // widget.post.date,
                      // DateFormatr(widget.post.date),
                      style: MyFonts.thin.setColor(kGrey),
                    ),
                    MySpaces.vGapInBetween,
                  ],
                ),
              )
            ],
          );
  }
}
