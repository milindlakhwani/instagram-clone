import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/screens/chat.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/signup.dart';

import 'screens/welcome.dart';
import './screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: Welcome(),
      routes: {
        LogIn.routeName: (ctx) => LogIn(),
        SignUp.routeName: (ctx) => SignUp(),
        HomePage.routeName: (ctx) => HomePage(),
        Chat.routeName: (ctx) => Chat(),
      },
    );
  }
}
