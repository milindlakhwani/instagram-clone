import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';

class Button extends StatelessWidget {
  final String text;
  final Function func;

  const Button({this.text, this.func});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: SizeConfig.verticalBlockSize * 3.5),
      width: double.infinity,
      child: TextButton(
        child: Text(
          text,
          style: MyFonts.light.tsFactor(18).setColor(kWhite),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: kBlue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        onPressed: func,
      ),
    );
  }
}
