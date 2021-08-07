import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_ui_clone/screens/add_post.dart';

BuildContext context;

void init(BuildContext ctx) {
  context = ctx;
}

void navigate() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddPost(ImageSource.camera)),
  );
}
