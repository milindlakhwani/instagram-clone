import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/providers/posts.dart';
import 'package:provider/provider.dart';
import '../providers/DUMMY_DATA.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/widgets/user_post.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = DummyData();
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            // color: Colors.green,
            padding: EdgeInsets.symmetric(vertical: 10),
            height: SizeConfig.verticalBlockSize * 16,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...data.stories.map((story) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: CircleAvatar(
                          radius: SizeConfig.horizontalBlockSize * 8,
                          child: ClipRRect(
                            child: Image.asset(story.imageUrl),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      MySpaces.vSmallestGapInBetween,
                      FittedBox(child: Text(story.userName)),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: kWhite.withOpacity(0.5),
          ),
          Consumer<Posts>(builder: (ctx, posts, _) {
            return Column(
              children: [
                ...posts.posts.map((post) => UserPost(post)).toList(),
              ],
            );
          }),
          // ...data.posts.map((post) {
          //   return UserPost(post);
          // }).toList(),
          // StreamBuilder(stream: ,builder: null ,),
          // FutureBuilder(future:  , builder: null)
        ],
      ),
    );
  }
}
