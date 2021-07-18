import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo(this.size);
  @override
  Widget build(BuildContext context) {
    return Text(
      "Instagram",
      style: TextStyle(
        fontFamily: "FontSpring",
        fontSize: size,
        color: kWhite,
      ),
    );
  }
}
