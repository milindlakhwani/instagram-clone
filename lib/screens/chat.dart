import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/providers/DUMMY_DATA.dart';

class Chat extends StatelessWidget {
  static const routeName = "/chat";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              FirebaseAuth.instance.currentUser.displayName,
              style: MyFonts.light.size(20),
            ),
            MySpaces.hGapInBetween,
            Icon(FontAwesomeIcons.angleDown),
          ],
        ),
        actions: [
          Icon(
            Icons.add,
            size: 28,
          ),
          MySpaces.hGapInBetween
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  hintStyle: MyFonts.light
                      .setColor(kGrey)
                      .size(SizeConfig.horizontalBlockSize * 5),
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  fillColor: matteBlack,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: border_color,
                      width: 0.75,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                style: MyFonts.light.setColor(kWhite),
              ),
              ...DummyData().chatWidgets,
            ],
          ),
        ),
      ),
    );
  }
}
