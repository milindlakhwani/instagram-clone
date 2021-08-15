import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';

class UserButton extends StatelessWidget {
  final Function func;
  final String text;
  final IconData icon;

  const UserButton(this.func, this.text, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: func,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kWhite,
            ),
            MySpaces.hGapInBetween,
            Text(
              text,
              style: MyFonts.light.setColor(kWhite).size(17),
            ),
          ],
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 7),
          backgroundColor: kBlack,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: kWhite.withOpacity(0.5), width: 0.5),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
