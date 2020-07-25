import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';

class DirPopup extends StatelessWidget {
  final String path;
  final Function popTap;

  DirPopup({
    Key key,
    @required this.path,
    @required this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: popTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0))) ,

      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(
         mainAxisAlignment:  MainAxisAlignment.center,
            children:[ Text(
              "Rename",
            ),
            ]
          ),
        ),
        PopupMenuDivider(
      
        ),
        PopupMenuItem(
          value: 1,
          
         child: Row(
         mainAxisAlignment:  MainAxisAlignment.center,
            children:[ Text(
              "Delete",
            ),
            ]
          ),
        ),
      ],
      icon: Icon(
        Icons.settings,
        color: Colors.lightBlue,
      ),
      color: AppTheme.notWhite,
      offset: Offset(0, 700),
    
    );
  }
}
