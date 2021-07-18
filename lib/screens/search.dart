import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/providers/DUMMY_DATA.dart';

class Search extends StatelessWidget {
  final data = DummyData();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: appbarColor,
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...["IGTV", "Shop", "Style", "Sports", "Auto", "Random"]
                        .map((text) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              backgroundColor: kBlack,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: kGrey.withOpacity(0.5), width: 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              text,
                              style: MyFonts.medium
                                  .setColor(kWhite)
                                  .size(SizeConfig.horizontalBlockSize * 4),
                            )),
                      );
                    }).toList()
                  ],
                ),
              ),
              MySpaces.vGapInBetween,
              StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                itemCount: data.searchImages.length,
                itemBuilder: (context, index) =>
                    Image.asset(data.searchImages[index]),
                staggeredTileBuilder: (index) => StaggeredTile.count(
                    (index % 10 == 0) ? 2 : 1, (index % 10 == 0) ? 2 : 1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            ],
          )),
    );
  }
}
