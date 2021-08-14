import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_ui_clone/globals/myColors.dart';
import 'package:instagram_ui_clone/globals/myFonts.dart';
import 'package:instagram_ui_clone/globals/mySpaces.dart';
import 'package:instagram_ui_clone/globals/sizeConfig.dart';
import 'package:instagram_ui_clone/providers/posts.dart';
import 'package:instagram_ui_clone/providers/search_provider.dart';
import 'package:instagram_ui_clone/screens/profile_page.dart';
import 'package:instagram_ui_clone/widgets/bnb.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  static const routeName = 'search-page';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isSearching = false;
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    setState(() {
      isSearching = true;
    });
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        print(docs.docs);
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
          setState(() {
            tempSearchStore.add(queryResultSet[i]);
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['user_name'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element['user_name'].toLowerCase().indexOf(value.toLowerCase()) ==
              0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<Posts>(context).posts;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Container(
          height: 40,
          width: SizeConfig.verticalBlockSize * 80,
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: isSearching
                  ? IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      iconSize: 20.0,
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                        });
                      },
                    )
                  : IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.search),
                      iconSize: 20.0,
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                        });
                      },
                    ),
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
            onChanged: (val) {
              initiateSearch(val);
            },
          ),
        ),
        actions: [
          Icon(
            FontAwesomeIcons.instagram,
            size: SizeConfig.horizontalBlockSize * 8,
          ),
          MySpaces.hGapInBetween,
        ],
        // centerTitle: true,
      ),
      body: isSearching
          ? SingleChildScrollView(
              child: Column(
                children: tempSearchStore.map((element) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                        ProfilePage.routeName,
                        arguments: element['userId'],
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(element['imageUrl'] ??
                            "https://i2.wp.com/wilkinsonschool.org/wp-content/uploads/2018/10/user-default-grey.png"),
                      ),
                      title: Text(element['user_name']),
                    ),
                  );
                }).toList(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                  color: appbarColor,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...[
                              "IGTV",
                              "Shop",
                              "Style",
                              "Sports",
                              "Auto",
                              "Random"
                            ].map((text) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 9, vertical: 3),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      backgroundColor: kBlack,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: kGrey.withOpacity(0.5),
                                            width: 1),
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
                                          .size(SizeConfig.horizontalBlockSize *
                                              4),
                                    )),
                              );
                            }).toList()
                          ],
                        ),
                      ),
                      MySpaces.vGapInBetween,
                      (Provider.of<Posts>(context, listen: false)
                              .queryList
                              .isEmpty)
                          ? Text("Follow someone")
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('addedBy',
                                      whereIn:
                                          Provider.of<Posts>(context).queryList)
                                  .snapshots(),
                              builder: (context, snapshots) {
                                if (snapshots.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                }
                                return StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  crossAxisCount: 3,
                                  itemCount: snapshots.data.docs.length,
                                  itemBuilder: (ctx, index) {
                                    final data = snapshots.data.docs[index]
                                        .data() as Map<String, dynamic>;
                                    return Image.network(
                                      data['imageUrl'],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  // itemBuilder: (context, index) => Image.network(
                                  //   data[index].postUrl,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  staggeredTileBuilder: (index) =>
                                      StaggeredTile.count(
                                          (index % 10 == 0) ? 2 : 1,
                                          (index % 10 == 0) ? 2 : 1),
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                );
                              })
                    ],
                  )),
            ),
      bottomNavigationBar: Bnb(),
    );
  }
}
