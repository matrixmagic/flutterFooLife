import 'package:flutter/material.dart';

import '../AppTheme.dart';

class FilePopup extends StatelessWidget {
  final String path;
  final Function popTap;

  FilePopup({
    Key key,
    @required this.path,
    @required this.popTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: popTap,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Text(
            "Rename",
          ),
        ),
      PopupMenuDivider(
      
        ),
        PopupMenuItem(
          value: 1,
          child: Text(
            "Delete",
          ),
        ),
//        PopupMenuItem(
//          value: 2,
//          child: Text(
//            "Info",
//          ),
//        ),
      ],
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.lightBlue,
      ),
      color: AppTheme.notWhite,
      offset: Offset(0, 30),
    );
  }
}
