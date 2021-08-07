import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/widgets/bnb.dart';
import 'package:instagram_ui_clone/widgets/dm_button.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';

class Activity extends StatelessWidget {
  static const routeName = 'activity';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        leading: Icon(
          Icons.camera_alt_outlined,
          size: SizeConfig.horizontalBlockSize * 7,
        ),
        title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
        centerTitle: true,
        actions: [
          DmButton(),
          MySpaces.hGapInBetween,
        ],
      ),
      body: Container(
        child: Text("No data here"),
      ),
      bottomNavigationBar: Bnb(),
    );
  }
}
