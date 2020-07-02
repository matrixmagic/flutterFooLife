import 'package:flutter/material.dart';
import 'package:foolife/Screens/Restaurant/ExplorerScreen.dart';

class ManageMenuScreen extends StatefulWidget {
  @override
  _ManageMenuScreenState createState() => _ManageMenuScreenState();
}

class _ManageMenuScreenState extends State<ManageMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            
            body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        TabBar(tabs: [
            Tab(text: 'Category',
              icon: Icon(
                Icons.star,color: Colors.yellow,size: 35,
              ),
            ),
            Tab( text: 'Price',
              icon: Icon(
                Icons.favorite,color: Colors.red,size: 35,
              ),
            ),
            Tab( text: 'Time',
              icon: Icon(
                Icons.favorite,color: Colors.red,size: 35,
              ),
            ),
          
          
              ]),
              
                        
                      ],
                    ),
                  ),
                ),
                Expanded( child: 
             TabBarView(children: <Widget>[
            ExplorerScreen(title: "beka beka", path: "/mobile/ddd"),
            ExplorerScreen(title: "beka beka", path: "/mobile/ddd"),
            ExplorerScreen(title: "beka beka", path: "/mobile/ddd")


                
              ],
            )),
      
               ] ))));
  }
}
