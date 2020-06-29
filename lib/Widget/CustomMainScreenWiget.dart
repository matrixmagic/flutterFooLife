import 'package:flutter/material.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';


class CustomMainScreenWiget extends StatelessWidget {
  String backgroundImage;
  String restauranName;
  CustomMainScreenWiget({this.backgroundImage,this.restauranName});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(backgroundImage),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  child: Center(
                    child: Text(
                      restauranName,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),color:Colors.grey.withOpacity(0.5),) ,height: 370,
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
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          '22',
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
                            color: Colors.yellow,
                          ),
                        ),
                        Text('22')
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
                            color: Colors.cyan,
                          ),
                        ),
                        Text('22')
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
                            color: Colors.purple,
                          ),
                        ),
                        Text('22')
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.people,
                            size: 31,
                            color: Colors.black,
                          ),
                        ),
                        Text('22')
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.insert_comment,
                      size: 31,
                      color: Colors.cyanAccent,
                    ),
                  ),
                 
                ],
              ),
            ),
          ),
          


        
         Positioned(bottom:70 , child: Container(height:40 ,width: 500,child: MenuBar()))
        ]),


        
      ),
    );
  }
}
