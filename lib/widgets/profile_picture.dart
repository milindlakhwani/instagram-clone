import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../globals/sizeConfig.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File _imageFile;
  final picker = ImagePicker();
  final _auth = FirebaseAuth.instance;
  var isLoading = false;

  // fucntion to set the user profile picture
  Future pickImage() async {
    // Open gallery to select the image
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // run the build method again to show a loading spinner at the place of this widget
    setState(() {
      _imageFile = File(pickedFile.path);
      isLoading = true;
    });

    // Upload the image to firebase storage with the name as UserId
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('images/${_auth.currentUser.uid}/profile_pic');
    final uploadTask = firebaseStorageRef.putFile(_imageFile);

    // the response that firebase returns us in uploadTask is the URL of the image which we can show in our app
    uploadTask.then((taskSnapshot) {
      taskSnapshot.ref.getDownloadURL().then((value) async {
        try {
          await _auth.currentUser.updatePhotoURL(value);
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: isLoading
          ? CircularProgressIndicator() //Show a loading spinner while uploading the image
          : CircleAvatar(
              radius: SizeConfig.horizontalBlockSize * 11,
              backgroundImage: NetworkImage(
                FirebaseAuth.instance.currentUser.photoURL ??
                    "https://i2.wp.com/wilkinsonschool.org/wp-content/uploads/2018/10/user-default-grey.png",
              ),
              // ?? syntax is used to check if a particular value is null and if it is null then do something else
              // In this case if there is no photoUrl then a default image would be shown to the user
            ),
    );
  }
}
