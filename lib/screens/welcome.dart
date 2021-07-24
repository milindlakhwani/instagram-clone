import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/login.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:instagram_ui_clone/widgets/button.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      User result = FirebaseAuth.instance.currentUser;
      if (result != null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.horizontalBlockSize * 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Logo(SizeConfig.textScaleFactor * 55),
              Column(
                children: [
                  Button(
                    text: "Log In",
                    func: () =>
                        Navigator.of(context).pushNamed(LogIn.routeName),
                  ),
                  Button(
                    text: "Sign Up",
                    func: () =>
                        Navigator.of(context).pushNamed(SignUp.routeName),
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
