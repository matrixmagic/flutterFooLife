import 'package:flutter/material.dart';
import 'package:foolife/Screens/Main/NotificationTabs/FavoriteTab.dart';
import 'package:foolife/Screens/Main/NotificationTabs/LikesTab.dart';

import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';
import 'NotificationTabs/CommentTab.dart';
import 'NotificationTabs/ComplaintsTab.dart';
import 'NotificationTabs/ViewersTab.dart';

class NotificationScreen extends StatelessWidget {
  @override
  var images = [
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg'
  ];
  var names = ['KFC', 'Pizza Hut', 'McDonald'];
  Widget build(BuildContext context) {
    _context=context;
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        TabBar(tabs: [
                          Tab(
                            text: 'Favorite',
                            icon: Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 35,
                            ),
                          ),
                          Tab(
                            text: 'Likes',
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                              size: 35,
                            ),
                          ),
                          Tab(
                            text: 'Comments',
                            icon: Icon(
                              Icons.comment,
                              color: Colors.cyan,
                              size: 35,
                            ),
                          ),
                          Tab(
                            text: 'viewrs',
                            icon: Icon(
                              Icons.person,
                              color: Colors.greenAccent,
                              size: 35,
                            ),
                          ),
                          Tab(
                            text: 'Complaints',
                            icon: Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 35,
                            ),
                          )
                        ]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      FavoriteTab(),
                      LikesTab(),
                      CommentTab(),
                      ViewersTab(),
                      ComplaintsTab(),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 5.0,
              right: 5.0,
              child: CustomButtomNavigatior(),
            ),
          ],
        )),
      ),
    );
  }
  _ParentFunction() async {
   

    await _showSelectionDialog(_context);
  }
BuildContext _context;
  Future<void> _showSelectionDialog(BuildContext context) async {
    print('im clicked hiiiii');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Sign up"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/usersignup');
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Log in"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signin');
                  },
                )
              ],
            ),
          ));
        });
  }
}
