import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Screens/Main/CategoriesScreen.dart';

class MenuBar extends StatefulWidget {
  List<CategoryDto> items;
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
          index = index % (widget.items.length + 1);
          if (index == 0) {
            return GestureDetector(
              child: Container(
               
                padding: EdgeInsets.symmetric(horizontal: 10),
              
                child: Icon(
                  Icons.local_dining,
                  size: 30,
                  color: AppTheme.notWhite.withOpacity(0.7),
                ),
              ),
            );
          }
          else if(widget.items[index - 1].products==null) {
             return Container();
          }
          else if(widget.items[index - 1].products.length<=0){
             return Container();
          }

          
          return GestureDetector(
            onTap: () async {
              FlutterSecureStorage storage = new FlutterSecureStorage();
              await storage.write(key: "_lastButtonPreesed", value: "-1");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoriesScreen(
                          categoryId: widget.items[index - 1].id,
                          restaurantid: widget.items[index - 1].restaurantId,
                        )),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
             
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(44)),
                height: 60,
                child: Text(
                  widget.items[index - 1].name,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppTheme.notWhite,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
