import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/screens/add_post.dart';
import 'package:instagram_ui_clone/screens/edit_profile_screen.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:instagram_ui_clone/widgets/bnb.dart';
// import 'package:instagram_ui_clone/widgets/button.dart';
import 'package:instagram_ui_clone/widgets/follow_button.dart';
import 'package:instagram_ui_clone/widgets/profile_picture.dart';
import 'package:instagram_ui_clone/widgets/user_button.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile-page';

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = ModalRoute.of(context).settings.arguments as String;
    return StreamBuilder2(
      streams: Tuple2(
          _db
              .collection('posts')
              .where('addedBy', isEqualTo: _db.doc('/users/$currentUser'))
              .snapshots(),
          _db.collection('users').doc(currentUser).snapshots()),
      builder: (context, snapshots) {
        if (snapshots.item1.connectionState == ConnectionState.waiting ||
            snapshots.item2.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          bottomNavigationBar: Bnb(),
          backgroundColor: appbarColor,
          appBar: AppBar(
            backgroundColor: appbarColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshots.item2.data['user_name'],
                  style: MyFonts.light.size(20),
                ),
                MySpaces.hGapInBetween,
                Icon(FontAwesomeIcons.angleDown),
              ],
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
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
                            ProfilePicture(
                              imageUrl: snapshots.item2.data['imageUrl'] ??
                                  "https://i2.wp.com/wilkinsonschool.org/wp-content/uploads/2018/10/user-default-grey.png",
                            ),
                            MySpaces.hGapInBetween,
                            Expanded(
                              child: DefaultTextStyle(
                                style: MyFonts.medium.size(18),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                            "${snapshots.item1.data.docs.length}" ??
                                                ''),
                                        Text("Posts"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            "${snapshots.item2.data['followers'].length}"),
                                        Text("Followers"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            "${snapshots.item2.data['following'].length}"),
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
                          snapshots.item2.data['user_name'] ?? 'Nil',
                          style: MyFonts.light.size(15),
                        ),
                        Text(
                          snapshots.item2.data['bio'],
                          style: MyFonts.light.size(15),
                        ),
                        MySpaces.vGapInBetween,
                        (currentUser == _auth.currentUser.uid)
                            ? Column(
                                children: [
                                  UserButton(() {
                                    _auth.signOut();
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            SignUp.routeName, (route) => false);
                                  }, "Log Out", Icons.logout_outlined),
                                  UserButton(() {
                                    Navigator.of(context)
                                        .pushNamed(EditProfile.routeName);
                                  }, "Edit Profile", Icons.edit),
                                ],
                              )
                            : (snapshots.item2.data['followers'] as List)
                                    .contains(_auth.currentUser.uid)
                                ? FollowButton("Following", currentUser,
                                    snapshots.item2.data['followers'] as List)
                                : FollowButton("Follow", currentUser,
                                    snapshots.item2.data['followers'] as List),
                        MySpaces.vSmallestGapInBetween,
                      ],
                    ),
                  ),
                  Divider(
                    color: kWhite.withOpacity(0.2),
                    height: 0.5,
                  ),
                  MySpaces.vGapInBetween,
                  ((snapshots.item2.data['followers'] as List)
                              .contains(_auth.currentUser.uid) ||
                          currentUser == _auth.currentUser.uid)
                      ? (snapshots.item1.data.docs.length == 0)
                          ? Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 1,
                                          color: storyColor,
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddPost(ImageSource.gallery),
                                          ),
                                        ),
                                        // Icons.camera_alt_outlined,
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          size: SizeConfig.horizontalBlockSize *
                                              10,
                                        ),
                                        color: kWhite,
                                        iconSize: 50,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "No Posts Yet",
                                      style: MyFonts.light.size(25),
                                    ),
                                  ),
                                  Padding(
                                    // padding: const EdgeInsets.all(8.0),
                                    padding: const EdgeInsets.only(bottom: 18),
                                    child: Text(
                                      "When you share photos, they will appear on your profile.",
                                      overflow: TextOverflow.ellipsis,
                                      style: MyFonts.light.size(15),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              itemCount: snapshots.item1.data.docs.length,
                              itemBuilder: (ctx, index) {
                                final data = snapshots.item1.data.docs[index]
                                    .data() as Map<String, dynamic>;
                                return Image.network(
                                  data['imageUrl'],
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                      : Center(
                          child: Container(
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 1,
                                        color: storyColor,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddPost(ImageSource.gallery),
                                        ),
                                      ),
                                      // Icons.camera_alt_outlined,
                                      icon: Icon(
                                        Icons.lock,
                                        size:
                                            SizeConfig.horizontalBlockSize * 10,
                                      ),
                                      color: kWhite,
                                      iconSize: 50,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: Text(
                                    "This account is private",
                                    style: MyFonts.light.size(25),
                                  ),
                                ),
                                Padding(
                                  // padding: const EdgeInsets.all(8.0),
                                  padding: const EdgeInsets.only(bottom: 18),
                                  child: Text(
                                    "Follow this account to see their photos and videos",
                                    overflow: TextOverflow.ellipsis,
                                    style: MyFonts.light.size(15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // child: Text(
                          //   "Follow this account to see their posts",
                          //   style: MyFonts.light
                          //       .size(SizeConfig.horizontalBlockSize * 5),
                          // ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
