import 'package:flutter/material.dart';

import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';

class SearchScreen extends StatelessWidget {
  @override
  var images = [
    'assets/images/Restaurant1.jpg',
    'assets/images/Restaurant2.jpg',
    'assets/images/Restaurant3.jpg'
  ];
  var names = ['KFC', 'Pizza Hut', 'McDonald'];
  Widget build(BuildContext context) {
    return SafeArea(
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
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              autocorrect: true,
                              decoration: InputDecoration(
                                // errorText: snapshot.error,
                                labelText: 'Search',

                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Colors.white70,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  borderSide: BorderSide(
                                      color: AppTheme.primaryColor, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 12,
                              top: 10,
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      color: AppTheme.primaryColor),
                                  child: Icon(
                                    Icons.search,
                                    color: AppTheme.notWhite,
                                    size: 30,
                                  )))
                        ],
                      ),
                      Padding(
                padding: EdgeInsets.only(top:10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                      Icon(Icons.select_all,size: 40,),
                      Icon(Icons.location_on,size: 40),
                      Icon(Icons.favorite,size: 40,color: AppTheme.redText,)

                    ],
                ),
              )
                    ],
                  ),
                ),
              ),
              
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
    );
  }
}
