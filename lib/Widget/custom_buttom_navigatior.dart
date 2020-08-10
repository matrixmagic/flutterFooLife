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
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(40.0),
                //topRight: Radius.circular(40.0),
                // ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.2,
                      0.5,
                      0.8,
                      0.9
                    ],
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.grey.withOpacity(0.4),
                      Colors.grey.withOpacity(0.3),
                      Colors.grey.withOpacity(0.4),
                      Colors.white.withOpacity(0.1)
                    ]),
                //image: new DecorationImage(
                //image: new AssetImage('assets/images/gray.jpg'),
                //fit: BoxFit.cover,
                //),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
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
