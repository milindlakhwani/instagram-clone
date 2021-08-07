import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
// import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/screens/activity.dart';
import 'package:instagram_ui_clone/screens/add_post.dart';
import 'package:instagram_ui_clone/screens/home_page.dart';
import 'package:instagram_ui_clone/screens/profile_page.dart';
import 'package:instagram_ui_clone/screens/search.dart';

class Bnb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 50.0,
      alignment: Alignment.center,
      child: BottomAppBar(
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              color: kWhite,
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
            IconButton(
              color: kWhite,
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Search.routeName);
              },
            ),
            IconButton(
              color: kWhite,
              icon: Icon(
                Icons.add_box,
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(ImageSource.gallery),
                ),
              ),
            ),
            IconButton(
              color: kWhite,
              icon: Icon(FontAwesomeIcons.heart),
              iconSize: 20,
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Activity.routeName);
              },
            ),
            IconButton(
              color: kWhite,
              icon: CircleAvatar(
                backgroundImage: NetworkImage(FirebaseAuth
                        .instance.currentUser.photoURL ??
                    "https://i2.wp.com/wilkinsonschool.org/wp-content/uploads/2018/10/user-default-grey.png"),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProfilePage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
