import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/functions/upload_image.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
// import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  final ImageSource source;
  static const routeName = 'add-post';
  // final String arguements = ModalRoute.of(context).settings.arguments as String;

  const AddPost(this.source);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  File _imageFile;
  bool isLoading = false;
  String imageUrl;
  final picker = ImagePicker();

  Future pickImage() async {
    // ImageSource source;
    // print(uploadMethod + ' milind');
    // if (uploadMethod == 'Gallery') {
    //   source = ImageSource.gallery;
    // } else {
    //   source = ImageSource.camera;
    // }
    try {
      // Open gallery to select the image
      final pickedFile = await picker.pickImage(source: widget.source);

      // run the build method again to show a loading spinner at the place of this widget
      _imageFile = File(pickedFile.path);
    } catch (error) {
      print("Emror");
      print(error);
      Navigator.of(context).pop();
    }

    setState(() {
      isLoading = true;
    });

    // Upload the image to firebase storage with the name as UserId
    final firebaseStorageRef = FirebaseStorage.instance.ref().child(
        'images/${FirebaseAuth.instance.currentUser.uid}/${DateTime.now().toString()}');
    firebaseStorageRef.putFile(_imageFile).then((taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((value) {
        try {
          // await widget._auth.currentUser.updatePhotoURL(value);
          // Navigator.of(context).pushNamed(AddPosts.routeName, arguments: value);
          imageUrl = value;
        } catch (error) {
          print(error);
        }
        // Stop the loading once fetching and setting it done
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    pickImage();
    super.initState();
  }

  String _caption, _location;
  final _formKey = GlobalKey<FormState>();

  void save(String imageUrl) async {
    _formKey.currentState.save();
    final CollectionReference _db =
        FirebaseFirestore.instance.collection('posts');
    setState(() {
      isLoading = true;
    });
    try {
      await _db.add({
        'imageUrl': imageUrl,
        'caption': _caption,
        'location': _location,
        'addedBy': FirebaseAuth.instance.currentUser.displayName,
        'profileUrl': FirebaseAuth.instance.currentUser.photoURL,
        'timeStamp': DateTime.now(),
      });
    } catch (error) {
      print(error);
    }

    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlack,
        title: Text(
          "New Post",
          style: MyFonts.bold,
        ),
        actions: [
          IconButton(
            onPressed: () => save(imageUrl),
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(
                          top: 8,
                          right: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: Image.network(
                          imageUrl ??
                              "https://i.pinimg.com/564x/d7/22/d9/d722d9b3f8f8ae58d2fd3b4cb9dd657c.jpg",
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Add Caption"),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            _caption = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  MySpaces.vGapInBetween,
                  TextFormField(
                    decoration: InputDecoration(labelText: "Add Location"),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      _location = value;
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
