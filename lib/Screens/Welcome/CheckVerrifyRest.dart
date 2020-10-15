import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Bloc/AuthBloc.dart';
import 'package:foolife/Bloc/auth/Register/CheckVerfiy/VerfiyBloc.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Repository/AuthRepository.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';

class CheckVerrifyRest extends StatefulWidget {
  @override
  _CheckVerrifyRestState createState() => _CheckVerrifyRestState();
}

class _CheckVerrifyRestState extends State<CheckVerrifyRest> {
  @override
  var _contro = TextEditingController();
  final storage = new FlutterSecureStorage();
  bool firstTime = false;
  bool isverfied = false;
  bool textfieldenable = true;
  bool AGB = false;
  bool Datenschutzenerklarung = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Registeration',
            style: TextStyle(color: Colors.purple),
          ),
          backgroundColor: Colors.white),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 25, 35, 10),
              child: Text('Restaurant', style: TextStyle(fontSize: 18)),
            ),
            Text(
              'Please use your e-mail adress from your official Website',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled: textfieldenable,
                controller: _contro,
                autocorrect: true,
                decoration: InputDecoration(
                  //errorText:
                  //labelText: 'Email',
                  hintText: 'Email adress',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white70,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            isverfied
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('AGB'),
                            /* Checkbox(
                              onChanged: (x) {
                                setState(() {
                                  AGB = !AGB;
                                  print(AGB);
                                });
                              },
                              value: AGB,
                            ),*/
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  AGB = !AGB;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  color: AGB
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Datenschutzenerklarung'),
                            /*Checkbox(
                              onChanged: (x) {
                                setState(() {
                                  Datenschutzenerklarung = x;
                                });
                              },
                              value: Datenschutzenerklarung,
                            ),*/
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Datenschutzenerklarung =
                                      !Datenschutzenerklarung;
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: new BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  color: Datenschutzenerklarung
                                      ? Colors.lightGreenAccent[400]
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(50.0),
                            side: BorderSide(color: Colors.green)),
                        onPressed: () {},
                        color: AGB && Datenschutzenerklarung
                            ? Colors.green
                            : Colors.grey,
                        textColor: Colors.green,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('send verfication code'),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    ],
                  )
                : RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(50.0),
                        side: BorderSide(color: AppTheme.primaryColor)),
                    onPressed: () async {
                      // _contro.value
                      print('im pressed check');
                      int result = await AuthRepository()
                          .isEmailVerfied(_contro.value.text);
                      print(_contro.value.text);
                      print(result);
                      if (result == 200) {
                        var verficationEmail = await storage.write(
                            key: "_verficationEmail",
                            value: _contro.value.text);
                        setState(() {
                          isverfied = true;
                          textfieldenable = false;
                        });
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.grey[500],
                    child: Text(
                      AppLocalizations.of(context).translate('check'),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

///////////////////////////

            SizedBox(height: 60),

            // register(context),

            Container(
              height: 60,
              width: 60,
              color: Colors.blue,
            ),
            Text('als user registeration',
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                )),
            SizedBox(height: 20),
            GestureDetector(
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 24,
                  decoration: TextDecoration.underline,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/usersignup');
              },
            ),
            SizedBox(height: 25),
            Text('Impressum',
                style: TextStyle(
                  fontSize: 22,
                  decoration: TextDecoration.underline,
                ))
          ],
        ),
      ),
    );
  }
}
