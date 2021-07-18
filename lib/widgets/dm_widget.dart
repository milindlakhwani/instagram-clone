import 'package:flutter/material.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/widgets/story.dart';
// import 'grey_ring_widget.dart';

class ChatBox extends StatelessWidget {
  final String chatImage;
  final String chatName;
  final String chatDetail;
  final String time;
  final bool ringEnabled;

  ChatBox({
    @required this.chatImage,
    @required this.chatName,
    @required this.chatDetail,
    @required this.time,
    @required this.ringEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: ringEnabled
            ? Story(
                imageUrl: chatImage,
                radii: SizeConfig.horizontalBlockSize * 7,
              )
            : CircleAvatar(
                backgroundImage: AssetImage(chatImage),
                radius: SizeConfig.horizontalBlockSize * 8.25,
              ),
      ),
      title: Text(
        chatName,
        style: MyFonts.medium.setColor(kWhite),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.horizontalBlockSize * 40,
            child: Text(
              chatDetail,
              // softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: MyFonts.light.setColor(kWhite.withOpacity(0.6)),
            ),
          ),
          Text(
            ".$time",
            style: MyFonts.light.setColor(kWhite.withOpacity(0.6)),
          ),
        ],
      ),
      trailing: Icon(Icons.camera_alt_outlined),
    );
  }
}
