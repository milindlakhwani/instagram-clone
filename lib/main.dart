import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/providers/authentication.dart';
import 'package:instagram_ui_clone/screens/add_posts.dart';
import 'package:instagram_ui_clone/screens/chat.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
import 'package:provider/provider.dart';

import 'screens/welcome.dart';
import './screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Authentication(),
      child: MaterialApp(
        title: 'Instagram',
        theme: ThemeData.dark(),
        home: Welcome(),
        routes: {
          LogIn.routeName: (ctx) => LogIn(),
          SignUp.routeName: (ctx) => SignUp(),
          HomePage.routeName: (ctx) => HomePage(),
          Chat.routeName: (ctx) => Chat(),
          AddPosts.routeName: (ctx) => AddPosts(),
        },
      ),
    );
  }
}
