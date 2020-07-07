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
            BoxDecoration activeButtonDec = BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white));
            int lastButtonPreesed;
            if (snapshot.hasData)
              lastButtonPreesed = int.parse(snapshot.data as String);
            else {
              lastButtonPreesed = 1;
            }
            return Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      decoration:
                          lastButtonPreesed == 1 ? activeButtonDec : null,
                      child: IconButton(
                          icon: Icon(
                            Icons.home,
                            color: AppTheme.notWhite,
                          ),
                          onPressed: () async {
                            await storage.write(
                                key: "_lastButtonPreesed", value: "1");

                            Navigator.of(context)
                                .pushReplacementNamed('/mainscreen');
                          })),
                  Container(
                      decoration:
                          lastButtonPreesed == 2 ? activeButtonDec : null,
                      child: IconButton(
                        icon: Icon(Icons.search, color: AppTheme.notWhite),
                        onPressed: () async {
                          await storage.write(
                              key: "_lastButtonPreesed", value: "2");

                          Navigator.of(context)
                              .pushReplacementNamed('/searchscreen');
                        },
                      )),
                  Container(
                      decoration:
                          lastButtonPreesed == 3 ? activeButtonDec : null,
                      child: IconButton(
                        icon: Icon(Icons.create, color: AppTheme.notWhite),
                        onPressed: () async {
                          await storage.write(
                              key: "_lastButtonPreesed", value: "3");

                          Navigator.of(context)
                              .pushReplacementNamed('/notificationscreen');
                        },
                      )),
                  Container(
                      decoration:
                          lastButtonPreesed == 4 ? activeButtonDec : null,
                      child: IconButton(
                        icon: Icon(Icons.favorite, color: AppTheme.notWhite),
                        onPressed: () async {
                          await storage.write(
                              key: "_lastButtonPreesed", value: "4");

                          Navigator.of(context)
                              .pushReplacementNamed('/notificationscreen');
                        },
                      )),
                  Container(
                      decoration:
                          lastButtonPreesed == 5 ? activeButtonDec : null,
                      child: IconButton(
                        icon: Icon(Icons.person_outline,
                            color: AppTheme.notWhite),
                        onPressed: () async {
                          await storage.write(
                              key: "_lastButtonPreesed", value: "5");
                          var validUser = await AuthRepository().CheckToken();
                          if (validUser == true) {
                            Navigator.of(context)
                                .pushReplacementNamed('/mangemenuscreen');
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
