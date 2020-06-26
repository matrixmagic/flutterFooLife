import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';

class CustomButtomNavigatior extends StatefulWidget {
  @override
  _CustomButtomNavigatiorState createState() => _CustomButtomNavigatiorState();
}

class _CustomButtomNavigatiorState extends State<CustomButtomNavigatior> {
  @override
  Widget build(BuildContext context) {
    return Container(decoration:BoxDecoration(borderRadius:BorderRadius.circular(20),color:Colors.grey.withOpacity(0.5),) ,
      child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround ,children: <Widget>[

        IconButton(icon: Icon(Icons.home, color:AppTheme.notWhite) ,),
        IconButton(icon: Icon(Icons.search, color: AppTheme.notWhite) ,),
        IconButton(icon: Icon(Icons.group, color:AppTheme.notWhite) ,),
        IconButton(icon: Icon(Icons.favorite, color:AppTheme.notWhite) ,),
        IconButton(icon: Icon(Icons.person_outline, color:AppTheme.notWhite) ,)
      
      ],),
      
    );
  }
}