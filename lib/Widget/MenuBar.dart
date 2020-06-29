import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';

class MenuBar extends StatefulWidget {
  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          index=index%10;
          if(index==0){
          return   GestureDetector(
          
            
              child: Container(padding: EdgeInsets.symmetric( horizontal: 10),
               
                height: 70,
                child: Icon(Icons.home ,size: 30, color: AppTheme.notWhite,),
              ),
          
          );
          }
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(padding: EdgeInsets.symmetric( horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(44)),
                height: 60,
                child: Text("piza",style: TextStyle(color: AppTheme.notWhite),),
              ),
            ),
          );
        },
      ),
    );
  }
}
