import 'package:flutter/material.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/images/Restaurant.jpg' ),
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
                      'hallo',
                      style: TextStyle(color: Colors.white, fontSize: 44),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 25,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
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
                            Icons.favorite_border,
                            size: 31,
                            color: Colors.white,
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
                            Icons.star_border,
                            size: 31,
                            color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
        ,Positioned(bottom: 0 ,left: 5.0,right: 5.0,child: CustomButtomNavigatior(),)
        
        ]),


        
      ),
    );
  }
}
