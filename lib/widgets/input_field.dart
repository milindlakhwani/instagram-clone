import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';

class InputField extends StatelessWidget {
  final String text;
  final bool isPass;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  const InputField({
    this.text,
    this.isPass = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          hintStyle: MyFonts.light.setColor(kGrey),
          filled: true,
          contentPadding: EdgeInsets.all(15),
          fillColor: matteBlack,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: border_color,
              width: 0.75,
            ),
          ),
        ),
        textInputAction: textInputAction,
        obscureText: isPass,
        keyboardType: textInputType,
        style: MyFonts.light.setColor(kWhite),
      ),
    );
  }
}
