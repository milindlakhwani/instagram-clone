import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
// import 'package:instagram_ui_clone/models/post.dart';
// import 'package:instagram_ui_clone/models/user.dart';
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
          (Provider.of<Posts>(context, listen: false).queryList.isEmpty)
              ? Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: storyColor,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              FontAwesomeIcons.userAlt,
                              size: SizeConfig.horizontalBlockSize * 10,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        // padding: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Text(
                          "Follow someone to see their posts in feed",
                          overflow: TextOverflow.ellipsis,
                          style: MyFonts.light.size(15),
                        ),
                      ),
                    ],
                  ),
                )
              : StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('posts')
                      .where('addedBy',
                          whereIn: Provider.of<Posts>(context).queryList)
                      .snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Column(
                      children: Provider.of<Posts>(context)
                          .setViva(snapshots.data.docs)
                          .map((post) {
                        return UserPost(post);
                      }).toList(),
                    );
                  }),
        ],
      ),
    );
  }
}
