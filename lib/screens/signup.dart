import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/providers/authentication.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/login.dart';
import 'package:instagram_ui_clone/widgets/button.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'sign-up';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  var isLoading = false;

  String _email, _password, _name;

  void trySignIn() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    setState(() {
      isLoading = true;
    });
    _formKey.currentState.save();
    final authInstance = Provider.of<Authentication>(context, listen: false);

    try {
      await authInstance.signUp(_name, _email, _password);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
    } catch (error) {
      authInstance.showError(error.toString(), context);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: AppBar(
        backgroundColor: kBlack,
        brightness: Brightness.dark,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  MySpaces.vGapInBetween,
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Username",
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
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter your name";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _name = value;
                                    },
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    style: MyFonts.light.setColor(kWhite),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Email",
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
                                    onSaved: (value) {
                                      _email = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter your email";
                                      }
                                      if (!value.contains("@") ||
                                          !value.contains(".")) {
                                        return "Please enter a valid email address";
                                      }

                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    style: MyFonts.light.setColor(kWhite),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Password",
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
                                    controller: _passwordController,
                                    onFieldSubmitted: (value) {
                                      _passwordController.text = value;
                                    },
                                    onSaved: (value) {
                                      _password = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter a password";
                                      }
                                      if (value.length < 6) {
                                        return "Please enter a password greator than 6 characters";
                                      }

                                      return null;
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.next,
                                    style: MyFonts.light.setColor(kWhite),
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Confirm Password",
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
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Please enter your password again";
                                      }
                                      if (value != _passwordController.text) {
                                        return "Passwords do not match";
                                      }

                                      return null;
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    style: MyFonts.light.setColor(kWhite),
                                  ),
                                  MySpaces.vSmallestGapInBetween,
                                  Button(
                                    text: "Sign Up",
                                    func: trySignIn,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (SizeConfig.screenWidth -
                                              (2 *
                                                  SizeConfig
                                                      .horizontalBlockSize *
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
                                                  SizeConfig
                                                      .horizontalBlockSize *
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
                                  "Have an account?",
                                  style: MyFonts.light
                                      .setColor(kWhite)
                                      .letterSpace(0.5),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .popAndPushNamed(LogIn.routeName),
                                  child: Text(
                                    " Log In.",
                                    style: MyFonts.light
                                        .setColor(kBlue)
                                        .letterSpace(1),
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
                              vertical: SizeConfig.verticalBlockSize * 2.5),
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
