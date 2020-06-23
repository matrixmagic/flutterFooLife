import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: <Widget>
        [
          Positioned.fill(  //
            child: Image(
              image: AssetImage('assets/images/Restaurant.jpg'),
              fit : BoxFit.fill,
           ),
          ), 
          
         ]
 ),
      bottomNavigationBar: BottomNavigationBar(
      showSelectedLabels: false,
      
        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.home  ,color :Colors.black38),
            title: Text('Home'),
            
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search ,color :Colors.black38),
            title: Text('Home'),
           
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group  ,color :Colors.black38),
            title: Text('Home'),
           
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite  ,color :Colors.black38),
            title: Text('Home'),
           
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color :Colors.black38 ),
            title: Text('Home'),
           
          ),
        ],
     //   currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
      //  onTap: _onItemTapped,
      ),
    );
  }
}
