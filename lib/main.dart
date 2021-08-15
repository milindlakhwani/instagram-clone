import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/providers/authentication.dart';
import 'package:instagram_ui_clone/providers/posts.dart';
import 'package:instagram_ui_clone/screens/activity.dart';
import 'package:instagram_ui_clone/screens/chat.dart';
import 'package:instagram_ui_clone/screens/edit_profile_screen.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/profile_page.dart';
import 'package:instagram_ui_clone/screens/search.dart';
import 'package:instagram_ui_clone/screens/signup.dart';
// import 'package:instagram_ui_clone/screens/test.dart';
// import 'package:instagram_ui_clone/screens/add_post.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Posts(),
        ),
      ],
      child: MaterialApp(
        title: 'Instagram',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: Welcome(),
        routes: {
          LogIn.routeName: (ctx) => LogIn(),
          SignUp.routeName: (ctx) => SignUp(),
          HomePage.routeName: (ctx) => HomePage(),
          Search.routeName: (ctx) => Search(),
          Activity.routeName: (ctx) => Activity(),
          ProfilePage.routeName: (ctx) => ProfilePage(),
          Chat.routeName: (ctx) => Chat(),
          EditProfile.routeName: (ctx) => EditProfile(),
        },
      ),
    );
  }
}
