

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
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

     @override
  void initState() {
    // TODO: implement initState
 SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent ));

  }


  BuildContext _context;

  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        FutureBuilder<Object>(
          future:  RestaurantRepository().gatAllResturants(),
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.connectionState ==ConnectionState.done){
            List<RestaurantDto> restaurents= snapshot.data;

            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return CustomMainScreenWiget(

                  restauranDto: restaurents[index],
                  cateogries: restaurents[index].categories,
                );
              },
              itemCount: restaurents.length,
              scrollDirection: Axis.vertical,
              scale: 1.0,
            );}else{
            return Container();

            }

            }
          
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
    ));
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