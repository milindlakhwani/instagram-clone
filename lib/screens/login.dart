import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/providers/authentication.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:instagram_ui_clone/widgets/button.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  static const routeName = 'log-in';

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  // Initializing Fields
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  var isLoading = false;

  // method to log the user in and navigate to homescreen
  // also to show a dialog box in case of error
  void tryLogIn() async {
    if (!_formKey.currentState.validate()) {
      return null;
    }
    _formKey.currentState.save();

    final authInstance = Provider.of<Authentication>(context, listen: false);

    setState(() {
      isLoading = true;
    });
    try {
      await authInstance.login(_email, _password);

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
          ? Center(
              child: CircularProgressIndicator()) //Show a spinner when loading
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Logo(SizeConfig.textScaleFactor * 55),
                              Column(
                                children: [
                                  MySpaces.vGapInBetween,
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
                                    style: MyFonts.light.setColor(kWhite),
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
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
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Password text field
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
                                    style: MyFonts.light.setColor(kWhite),
                                    obscureText: true, //to hide the characters
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
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
                                    func: tryLogIn,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    "Don't have an account?",
                                    style: MyFonts.light
                                        .setColor(kWhite)
                                        .letterSpace(0.5),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .popAndPushNamed(SignUp.routeName),
                                    child: Text(
                                      " Sign Up.",
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
