// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';

import 'package:instagram_ui_clone/globals/myColors.dart';
// import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/screens/add_post.dart';
// import 'package:instagram_ui_clone/screens/chat.dart';
// import 'package:instagram_ui_clone/models/user.dart';
import 'package:instagram_ui_clone/screens/feed.dart';
// import 'package:instagram_ui_clone/screens/activity.dart';
// import 'package:instagram_ui_clone/screens/profile_page.dart';
// import 'package:instagram_ui_clone/screens/search.dart';
// import 'package:instagram_ui_clone/screens/add_post.dart';
import 'package:instagram_ui_clone/widgets/bnb.dart';
import 'package:instagram_ui_clone/widgets/dm_button.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../functions/upload_image.dart' as imageUpload;

class HomePage extends StatefulWidget {
  static const routeName = "home-page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: appbarColor,
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPost(ImageSource.gallery),
            ),
          ),
          icon: Icon(
            Icons.camera_alt_outlined,
            size: SizeConfig.horizontalBlockSize * 7,
          ),
        ),
        title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
        centerTitle: true,
        actions: [
          DmButton(),
          MySpaces.hGapInBetween,
        ],
      ),
      body: Feed(),
      bottomNavigationBar: Bnb(),
    );
  }
}
