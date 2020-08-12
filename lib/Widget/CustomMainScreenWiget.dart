import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Screens/Restaurant/CreatePostScreen.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/my_flutter_app_icons.dart';

import 'package:foolife/Widget/stories_bar.dart';

import '../AppTheme.dart';

class CustomMainScreenWiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomMainScreenWiget();
  CustomMainScreenWiget(
      {this.backgroundImage, this.restauranName, this.cateogries});
  String backgroundImage;
  String restauranName;
  List<CategoryDto> cateogries;
}

class _CustomMainScreenWiget extends State<CustomMainScreenWiget> {
  bool mainScreenWidgetVisibility = true;
  bool postScreenWidgetVisibility = false;

  void openCreatePostScreen() {
    setState(() {
      mainScreenWidgetVisibility = false;
      postScreenWidgetVisibility = true;
    });
  }

  void closeCreatePostScreen() {
    setState(() {
      mainScreenWidgetVisibility = true;
      postScreenWidgetVisibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 7);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Stack(children: <Widget>[
          Container(
              child: CachedNetworkImage(
            imageUrl: widget.backgroundImage,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            fit: BoxFit.cover,
          )),
          Visibility(
            visible: postScreenWidgetVisibility,
            child: Container(child: CreatePost()),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  child: Center(
                    child: Text(
                      widget.restauranName,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 2,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: mainScreenWidgetVisibility,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 7,
                  bottom: MediaQuery.of(context).size.height / 4.5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [
                        0.1,
                        0.2,
                        0.5,
                        0.8,
                        0.9
                      ],
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.grey.withOpacity(0.6),
                        Colors.grey.withOpacity(0.3),
                        Colors.grey.withOpacity(0.6),
                        Colors.white.withOpacity(0.1)
                      ]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              size: 31,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            '22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.star,
                              size: 31,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.person,
                              size: 31,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              size: 31,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              MyFlutterApp.kellner_option,
                              size: 31,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)))
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.insert_comment,
                              size: 31,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              right: 5.0,
              bottom: 67,
              child: mainScreenWidgetVisibility
                  ? Container(
                      child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppTheme.notWhite,
                      ),
                      onPressed: openCreatePostScreen,
                    ))
                  : Container(
                      child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: AppTheme.notWhite,
                        size: 27,
                      ),
                      onPressed: closeCreatePostScreen,
                    ))),
          // Positioned(
          //   top: 26,
          //   left: 5.0,
          //   right: 5.0,
          //   //child: Container(child: storiesBar()),
          // ),
          Visibility(
            visible: mainScreenWidgetVisibility,
            child: widget.cateogries != null && widget.cateogries.length > 0
                ? Positioned(
                    bottom: 40,
                    child: Container(
                        height: 40,
                        width: 500,
                        child: MenuBar(items: widget.cateogries)))
                : Container(),
          )
        ]),
      ),
    );
  }
}
