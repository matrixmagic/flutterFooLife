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
