import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:instagram_ui_clone/widgets/button.dart';
import 'package:instagram_ui_clone/widgets/input_field.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';

class LogIn extends StatelessWidget {
  static const routeName = 'log-in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: SizeConfig.availableHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.horizontalBlockSize * 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Logo(SizeConfig.textScaleFactor * 55),
                      Column(
                        children: [
                          MySpaces.vGapInBetween,
                          InputField(
                            text: "Username",
                            textInputType: TextInputType.name,
                          ),
                          InputField(
                            text: "Password",
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.visiblePassword,
                            isPass: true,
                          ),
                          MySpaces.vGapInBetween,
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Forgot Password",
                              style: MyFonts.medium.setColor(kBlue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          MySpaces.vSmallestGapInBetween,
                          Button(
                            text: "Log In",
                            func: () => Navigator.of(context)
                                .pushNamedAndRemoveUntil(
                                    HomePage.routeName, (route) => false),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: (SizeConfig.screenWidth -
                                        (2 *
                                            SizeConfig.horizontalBlockSize *
                                            10)) /
                                    2 -
                                30,
                            height: 0.5,
                            color: kGrey.withOpacity(0.6),
                          ),
                          Text(
                            "OR",
                            style: MyFonts.medium
                                .factor(4)
                                .setColor(kGrey.withOpacity(0.9)),
                          ),
                          Container(
                            width: (SizeConfig.screenWidth -
                                        (2 *
                                            SizeConfig.horizontalBlockSize *
                                            10)) /
                                    2 -
                                30,
                            height: 0.5,
                            color: kGrey.withOpacity(0.6),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style:
                                MyFonts.light.setColor(kWhite).letterSpace(0.5),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .popAndPushNamed(SignUp.routeName),
                            child: Text(
                              " Sign Up.",
                              style:
                                  MyFonts.light.setColor(kBlue).letterSpace(1),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(
                    height: 1,
                    color: kWhite.withOpacity(0.3),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.verticalBlockSize * 5),
                    child: Text(
                      "Instagram from Facebook",
                      style: MyFonts.thin
                          .setColor(kWhite)
                          .size(SizeConfig.textScaleFactor * 15)
                          .letterSpace(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
