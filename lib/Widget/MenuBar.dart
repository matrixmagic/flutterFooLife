import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Screens/Main/CategoriesScreen.dart';

class MenuBar extends StatefulWidget {
   List<CategoryDto>  items;
   MenuBar({this.items});

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
          index=index % (widget.items.length+1) ;
          if(index==0){
          return   GestureDetector(
          
            
              child: Container(padding: EdgeInsets.symmetric( horizontal: 10),
               
                height: 70,
                child: Icon(Icons.home ,size: 30, color: AppTheme.notWhite,),
              ),
          
          );
          }
          return GestureDetector(
            onTap: (){
              Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CategoriesScreen(categoryId: widget.items[index-1].id,restaurantid: widget.items[index-1].restaurantId, )),
  );

            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(padding: EdgeInsets.symmetric( horizontal: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(44)),
                height: 60,
                child: Text(widget.items[index-1].name,style: TextStyle(color: AppTheme.notWhite),),
              ),
            ),
          );
        },
      ),
    );
  }
}
