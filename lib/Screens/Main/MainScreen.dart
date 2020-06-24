import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: Image(
              image: AssetImage('assets/images/Restaurant.jpg'),
              fit: BoxFit.fill,
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
            child: Container(
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
        ]),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.black38),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.black38),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group, color: Colors.black38),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black38),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Colors.black38),
              title: Text('Home'),
            ),
          ],
          //   currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          //  onTap: _onItemTapped,
        ),
      ),
    );
  }
}
