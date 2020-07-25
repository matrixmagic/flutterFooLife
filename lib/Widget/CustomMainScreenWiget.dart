import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/my_flutter_app_icons.dart';

import 'package:foolife/Widget/stories_bar.dart';


class CustomMainScreenWiget extends StatelessWidget {
  String backgroundImage;
  String restauranName;
  List<CategoryDto> cateogries;
  CustomMainScreenWiget({this.backgroundImage,this.restauranName,this.cateogries});
  @override
  Widget build(BuildContext context) {
  print(MediaQuery.of(context).size.height/7);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: Image(
              image:  NetworkImage(backgroundImage),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                
                  child: Center(
                    child: Text(
                      restauranName,
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
          Padding(
            padding: EdgeInsets.only( top: MediaQuery.of(context).size.height/7),
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
                        '22',style: TextStyle(color:Colors.white.withOpacity(0.8) ),
                        
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
                      Text('22' , style: TextStyle(color:Colors.white.withOpacity(0.8), ))
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
                      Text('22',style: TextStyle(color:Colors.white.withOpacity(0.8)  ))
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
                      Text('22', style: TextStyle(color:Colors.white.withOpacity(0.8) ))
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
                      Text('22' ,style: TextStyle(color:Colors.white.withOpacity(0.8) ))
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
                      Text('22' ,style: TextStyle(color:Colors.white.withOpacity(0.8) ))
                    ],
                  ),
                ),
                
              ],
            ),
          ),
          


          Positioned(top: 26 ,left: 5.0,right: 5.0,child: Container(child: storiesBar()),),  
       cateogries !=null&& cateogries.length>0? Positioned(bottom:40 , child: Container(height:40 ,width: 500,child: MenuBar(items:cateogries ) )):Container(),
        ]),


        
      ),
    );
  }
}
