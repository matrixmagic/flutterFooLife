
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foolife/Utility/consts.dart';


class SortSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Text(
              "Sort by".toUpperCase(),
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: Constants.sortList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () async {
                     
                      Navigator.pop(context);
                    },
                    contentPadding: EdgeInsets.all(0),
                    trailing: index ==
                            2
                        ? Icon(
                            Feather.check,
                            color: Colors.blue,
                            size: 16,
                          )
                        : SizedBox(),
                    title: Text(
                      "${Constants.sortList[index]}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: index ==
                               2
                            ? Colors.blue
                            :Colors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
