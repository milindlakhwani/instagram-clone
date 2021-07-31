import 'package:firebase_auth/firebase_auth.dart' as db;
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:instagram_ui_clone/widgets/profile_picture.dart';
import 'package:instagram_ui_clone/widgets/story.dart';
import 'package:instagram_ui_clone/models/user.dart';
import 'package:instagram_ui_clone/providers/DUMMY_DATA.dart';

class ProfilePage extends StatelessWidget {
  final User data = DummyData().currentUser;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: appbarColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicture(),
                      // Container(
                      //   padding: const EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       border: Border.all(
                      //         width: 1,
                      //         color: storyColor,
                      //       )),
                      //   child: CircleAvatar(
                      //     backgroundImage: AssetImage(data.imageUrl),
                      //     radius: SizeConfig.horizontalBlockSize * 12,
                      //   ),
                      // ),
                      MySpaces.hGapInBetween,
                      Expanded(
                        child: DefaultTextStyle(
                          style: MyFonts.medium.size(18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text("${data.postNum}"),
                                  Text("Posts"),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("${data.followers}"),
                                  Text("Followers"),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("${data.following}"),
                                  Text("Following"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  MySpaces.vGapInBetween,
                  Text(
                    data.displayname,
                    style: MyFonts.light.size(15),
                  ),
                  Text(
                    data.bio,
                    style: MyFonts.light.size(15),
                  ),
                  MySpaces.vGapInBetween,
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        db.FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            SignUp.routeName, (route) => false);
                      },
                      child: Text(
                        "Edit Profile",
                        style: MyFonts.light.setColor(kWhite).size(17),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        backgroundColor: kBlack,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: kWhite.withOpacity(0.5), width: 0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MySpaces.vSmallestGapInBetween,
                  Container(
                    // color: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    height: SizeConfig.verticalBlockSize * 14,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1,
                                color: storyColor,
                              )),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.add,
                              size: SizeConfig.horizontalBlockSize * 8,
                            ),
                            radius: SizeConfig.horizontalBlockSize * 8,
                          ),
                        ),
                        MySpaces.hGapInBetween,
                        Story(
                          imageUrl: data.imageUrl,
                          radii: SizeConfig.horizontalBlockSize * 8,
                        ),
                        MySpaces.hGapInBetween,
                        Story(
                          imageUrl: data.imageUrl,
                          radii: SizeConfig.horizontalBlockSize * 8,
                        ),
                        MySpaces.hGapInBetween,
                        Story(
                          imageUrl: data.imageUrl,
                          radii: SizeConfig.horizontalBlockSize * 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: kWhite.withOpacity(0.2),
              height: 0.5,
            ),
            MySpaces.vGapInBetween,
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: data.userPosts.length,
              itemBuilder: (ctx, index) {
                return Image.asset(data.userPosts[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
