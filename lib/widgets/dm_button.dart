import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/screens/chat.dart';

class DmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(Chat.routeName),
      icon: Icon(
        FontAwesomeIcons.paperPlane,
        size: SizeConfig.horizontalBlockSize * 7,
      ),
    );
  }
}
