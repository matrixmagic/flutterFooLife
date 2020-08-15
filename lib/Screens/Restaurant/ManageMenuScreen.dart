import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foolife/Screens/Restaurant/ExplorerScreen.dart';

import 'ProductsPrice.dart';

class ManageMenuScreen extends StatefulWidget {
  @override
  _ManageMenuScreenState createState() => _ManageMenuScreenState();
}

class _ManageMenuScreenState extends State<ManageMenuScreen> {


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
              
            ),
            Tab( text: 'Price',
            
            ),
            Tab( text: 'Time',
              
            ),
          
          
              ]),
              
                        
                      ],
                    ),
                  ),
                ),
                Expanded( child: 
             TabBarView(children: <Widget>[
            ExplorerScreen(title: "beka beka", path: "/mobile/ddd"),
            PorductPrice(),
            ExplorerScreen(title: "beka beka", path: "/mobile/ddd")


                
              ],
            )),
      
               ] ))));
  }
}
