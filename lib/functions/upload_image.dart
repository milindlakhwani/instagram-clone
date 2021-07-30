import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_ui_clone/screens/add_posts.dart';

final _auth = FirebaseAuth.instance;

File _imageFile;
final picker = ImagePicker();

// final context =

BuildContext context;

void init(BuildContext ctx) {
  context = ctx;
}

Future pickImage(ImageSource uploadMethod) async {
  // Open gallery to select the image
  final pickedFile = await picker.pickImage(source: uploadMethod);

  // run the build method again to show a loading spinner at the place of this widget
  _imageFile = File(pickedFile.path);

  // Upload the image to firebase storage with the name as UserId
  final firebaseStorageRef =
      FirebaseStorage.instance.ref().child('images/${_auth.currentUser.uid}/');
  final uploadTask = firebaseStorageRef.putFile(_imageFile);

  // the response that firebase returns us in uploadTask is the URL of the image which we can show in our app
  uploadTask.then((taskSnapshot) {
    taskSnapshot.ref.getDownloadURL().then((value) async {
      try {
        // await widget._auth.currentUser.updatePhotoURL(value);
        Navigator.of(context).pushNamed(AddPosts.routeName, arguments: value);
      } catch (error) {
        print(error);
      }
      // Stop the loading once fetching and setting it done
    });
  });
}
