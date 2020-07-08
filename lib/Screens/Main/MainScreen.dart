import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';

class MainScreen extends StatelessWidget {
  @override
  var images = [
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg'
  ];
  BuildContext _context;
  var names = ['KFC', 'Pizza Hut', 'McDonald'];
  Widget build(BuildContext context) {
    _context=context;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return CustomMainScreenWiget(
                backgroundImage: images[index],
                restauranName: names[index],
              );
            },
            itemCount: 3,
            scrollDirection: Axis.vertical,
            scale: 1.0,
          ),
          Positioned(
            bottom: 0,
            left: 5.0,
            right: 5.0,
            child: CustomButtomNavigatior(
              showDialog: _ParentFunction,
            ),
          ),
        ],
      )),
    );
  }
  _ParentFunction() async {
    print('im clickedxxxx hiiiii');

  await  _showSelectionDialog(_context);
  }
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
                  title: Text("Gallery"),
                  onTap: () {},
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Camera"),
                  onTap: () {},
                )
              ],
            ),
          ));
        });
  }
}
