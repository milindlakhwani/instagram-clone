import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
// import 'package:instagram_ui_clone/screens/chat.dart';
// import 'package:instagram_ui_clone/models/user.dart';
import 'package:instagram_ui_clone/screens/feed.dart';
import 'package:instagram_ui_clone/screens/likes.dart';
import 'package:instagram_ui_clone/screens/profile_page.dart';
import 'package:instagram_ui_clone/screens/search.dart';
import 'package:instagram_ui_clone/widgets/dm_button.dart';
import 'package:instagram_ui_clone/widgets/instagram_logo.dart';

class HomePage extends StatefulWidget {
  static const routeName = "home-page";
  final _auth = FirebaseAuth.instance;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _imageFile;
  final picker = ImagePicker();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Feed(),
    Search(),
    Center(
        child: Text(
      "Can't Access Camera",
      style: MyFonts.medium.size(SizeConfig.textScaleFactor * 25),
    )),
    Likes(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future pickImage() async {
    // Open gallery to select the image
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // run the build method again to show a loading spinner at the place of this widget
    setState(() {
      _imageFile = File(pickedFile.path);
    });

    // Upload the image to firebase storage with the name as UserId
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/${widget._auth.currentUser.uid}');
    final uploadTask = firebaseStorageRef.putFile(_imageFile);

    // the response that firebase returns us in uploadTask is the URL of the image which we can show in our app
    uploadTask.then((taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((value) async {
        try {
          await widget._auth.currentUser.updatePhotoURL(value);
        } catch (error) {
          print(error);
        }
        // Stop the loading once fetching and setting it done
      });
    });
  }

  static List<Widget> _appBars = <Widget>[
    AppBar(
      backgroundColor: appbarColor,
      leading: IconButton(
        onPressed: null,
        icon: Icon(
          Icons.camera_alt_outlined,
          size: SizeConfig.horizontalBlockSize * 7,
        ),
      ),
      title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
      centerTitle: true,
      actions: [
        DmButton(),
        MySpaces.hGapInBetween,
      ],
    ),
    AppBar(
      backgroundColor: appbarColor,
      title: Container(
        height: 40,
        width: SizeConfig.verticalBlockSize * 80,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: "Search",
            hintStyle: MyFonts.light
                .setColor(kGrey)
                .size(SizeConfig.horizontalBlockSize * 5),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            fillColor: matteBlack,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: border_color,
                width: 0.75,
              ),
            ),
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          style: MyFonts.light.setColor(kWhite),
        ),
      ),
      actions: [
        Icon(
          FontAwesomeIcons.instagram,
          size: SizeConfig.horizontalBlockSize * 8,
        )
      ],
      // centerTitle: true,
    ),
    AppBar(
      backgroundColor: appbarColor,
      leading: Icon(
        Icons.camera_alt_outlined,
        size: SizeConfig.horizontalBlockSize * 7,
      ),
      title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
      centerTitle: true,
      actions: [
        Icon(
          FontAwesomeIcons.paperPlane,
          size: SizeConfig.horizontalBlockSize * 7,
        ),
        MySpaces.hGapInBetween,
      ],
    ),
    AppBar(
      backgroundColor: appbarColor,
      leading: Icon(
        Icons.camera_alt_outlined,
        size: SizeConfig.horizontalBlockSize * 7,
      ),
      title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
      centerTitle: true,
      actions: [
        DmButton(),
        MySpaces.hGapInBetween,
      ],
    ),
    // PreferredSize(
    //   preferredSize: DummyData().tab.preferredSize,
    //   child: Card(
    //     elevation: 26.0,
    //     color: appbarColor,
    //     child: DummyData().tab,
    //   ),
    // ),
    AppBar(
      backgroundColor: appbarColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            FirebaseAuth.instance.currentUser.displayName,
            style: MyFonts.light.size(20),
          ),
          MySpaces.hGapInBetween,
          Icon(FontAwesomeIcons.angleDown),
        ],
      ),
      centerTitle: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBlack,
      appBar: _appBars[_selectedIndex],
      // AppBar(
      //   backgroundColor: appbarColor,
      //   leading: Icon(
      //     Icons.camera_alt_outlined,
      //     size: SizeConfig.horizontalBlockSize * 7,
      //   ),
      //   title: Center(child: Logo(SizeConfig.horizontalBlockSize * 7)),
      //   centerTitle: true,
      //   actions: [
      //     Icon(
      //       FontAwesomeIcons.paperPlane,
      //       size: SizeConfig.horizontalBlockSize * 7,
      //     ),
      //     MySpaces.hGapInBetween,
      //   ],
      // ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        backgroundColor: appbarColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: (_selectedIndex == 0)
                ? Icon(Icons.home)
                : Icon(Icons.home_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.plusSquare),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: (_selectedIndex == 3)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage: AssetImage("assets/images/img.png"),
            ),
            label: "",
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 35,
        onTap: _onItemTapped,
        elevation: 5,
      ),
    );
  }
}
