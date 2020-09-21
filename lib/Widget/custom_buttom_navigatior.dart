import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';

import 'package:foolife/Repository/AuthRepository.dart';

class CustomButtomNavigatior extends StatelessWidget {
  Function showDialog;
 
  CustomButtomNavigatior({this.showDialog});
  @override
  FlutterSecureStorage storage = new FlutterSecureStorage();
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: storage.read(key: "_lastButtonPreesed"),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            print("not fished");
            return Container();
          } else {
            int lastButtonPreesed;
            if (snapshot.hasData)
              lastButtonPreesed = int.parse(snapshot.data as String);
            else {
              lastButtonPreesed = 1;
            }
            return Container(
             
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 40.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                      child: IconButton(
                          icon: Icon(
                            Icons.home,
                            color: AppTheme.notWhite
                                .withOpacity(lastButtonPreesed == 1 ? 1 : 0.7),
                          ),
                          onPressed: () async {
                            await storage.write(
                                key: "_lastButtonPreesed", value: "1");
                   
                            Navigator.of(context)
                                .pushReplacementNamed('/mainscreen');
                          })),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 40.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                      child: IconButton(
                    icon: Icon(Icons.search,
                        color: AppTheme.notWhite
                            .withOpacity(lastButtonPreesed == 2 ? 1 : 0.7)),
                    onPressed: () async {
                      await storage.write(
                          key: "_lastButtonPreesed", value: "2");

                      Navigator.of(context)
                          .pushReplacementNamed('/searchscreen');
                    },
                  )),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 40.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                      child: IconButton(
                    icon: Icon(Icons.create,
                        color: AppTheme.notWhite
                            .withOpacity(lastButtonPreesed == 3 ? 1 : 0.7)),
                    onPressed: () async {
                      await storage.write(
                          key: "_lastButtonPreesed", value: "3");

                      Navigator.of(context)
                          .pushReplacementNamed('/notificationscreen');
                    },
                  )),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 40.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                      child: IconButton(
                    icon: Icon(Icons.favorite,
                        color: AppTheme.notWhite
                            .withOpacity(lastButtonPreesed == 4 ? 1 : 0.7)),
                    onPressed: () async {
                      await storage.write(
                          key: "_lastButtonPreesed", value: "4");

                      Navigator.of(context)
                          .pushReplacementNamed('/notificationscreen');
                    },
                  )),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 40.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
                      child: IconButton(
                    icon: Icon(
                      Icons.person_outline,
                      color: AppTheme.notWhite
                          .withOpacity(lastButtonPreesed == 5 ? 1 : 0.7),
                    ),
                    onPressed: () async {
                      await storage.write(
                          key: "_lastButtonPreesed", value: "5");
                      var validUser = await AuthRepository().CheckToken();
                      if (validUser == true) {
                        Navigator.of(context)
                            .pushReplacementNamed('/restaurantDetail');
                      } else
                        showDialog();
                    },
                  ))
                ],
              ),
            );
          }
        });
  }
}
