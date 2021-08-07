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
  // final String profileUrl = post.addedBy.id;

  const UserPost(this.post);

  @override
  _UserPostState createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  bool isFavourite = false;
  String profileUrl;
  String name;
  bool isLoading = true;

  @override
  void initState() {
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
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              setState(() {
                                isFavourite = !isFavourite;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: kBlack,
                                  content: Text(
                                    "You have ${isFavourite ? "liked" : "disliked"} the post",
                                    style:
                                        MyFonts.light.setColor(kWhite).size(15),
                                  ),
                                ),
                              );
                            },
                            icon: isFavourite
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
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 15,
                    //       backgroundImage:
                    //           AssetImage(widget.post.likedby[0].imageUrl),
                    //     ),
                    //     MySpaces.hGapInBetween,
                    //     Text(
                    //         "Liked by ${widget.post.likedby[0].userName} and ${widget.post.likedby.length - 1} others"),
                    //   ],
                    // ),
                    // MySpaces.vSmallestGapInBetween,
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
