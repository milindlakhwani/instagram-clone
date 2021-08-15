import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
// import 'package:instagram_ui_clone/providers/authentication.dart';
// import 'package:instagram_ui_clone/screens/profile_page.dart';
import 'package:instagram_ui_clone/widgets/profile_picture.dart';
// import 'package:provider/provider.dart';

// edit profile page  ----

class EditProfile extends StatefulWidget {
  static const routeName = '/edit_screen';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;
  String _userName;
  String _bio;
  final _formKey = GlobalKey<FormState>();

  void save() async {
    _formKey.currentState.save();
    print(_bio);
    print(_userName);
    setState(() {
      isLoading = true;
    });

    final _db = FirebaseFirestore.instance;
    if (_userName.isNotEmpty) {
      await _db
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({'user_name': _userName});
    }
    if (_bio.isNotEmpty) {
      await _db
          .collection('users')
          .doc(_auth.currentUser.uid)
          .update({'bio': _bio});
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: appbarColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 25,
            color: Colors.white,
            onPressed: () {},
          ),
          backgroundColor: Colors.black,
          title: Text(
            "Edit Profile",
            style: MyFonts.bold,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 10),
              child: CircleAvatar(
                backgroundColor: Colors.pink.shade200,
                child: IconButton(
                  onPressed: () => save(),
                  icon: Icon(Icons.check_rounded),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.pink))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProfilePicture(),
                      ),
                      Text(
                        'Change Profile Photo',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                        ),
                      ),
                      MySpaces.vGapInBetween,
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Username",
                            prefixIcon: Icon(
                              Icons.text_fields,
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _userName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Bio",
                            prefixIcon: Icon(Icons.album_outlined),
                          ),
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          textInputAction: TextInputAction.newline,
                          onSaved: (value) {
                            _bio = value;
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
