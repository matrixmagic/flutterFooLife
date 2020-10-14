import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../../AppTheme.dart';

class UserSignup extends StatelessWidget {
  bool firstTime = false;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();



  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);

    registerBloc.changeRole(1);

    return Scaffold(
      
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: registerBloc.submitRegisterStream,
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    if (snapshot2.data == true) {
                      if (firstTime) {
                        print("Navigator goo go");
          
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                      firstTime=!firstTime;
                          Navigator.of(context)
                              .pushReplacementNamed('/resturantSignup');
                        });
                      }
                    } else {
                      firstTime=!firstTime;
                      print("submit error");
                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                      return Text(snapshot2.error, style: AppTheme.error);
                    }
                  }
                  return Container();
                },
              ),
              email(registerBloc),
              password(registerBloc),
              confrimPassword(registerBloc),
              phoneNumber(registerBloc),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "    Register As",
                      style: AppTheme.body1,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    StreamBuilder(
                        stream: registerBloc.roleStream,
                        builder: (context, snapshot) {
                          return LiteRollingSwitch(
                            value: true,
                            textOn: 'Customer',
                            textOff: 'Restaurant',
                            colorOn: AppTheme.primaryColor,
                            colorOff: AppTheme.primaryColor,
                            iconOn: Icons.person_outline,
                            iconOff: Icons.restaurant_menu,
                            onChanged: (bool state) {
                              registerBloc.changeRole(state ? 1 : 2);
                            },
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
              registerButton(registerBloc),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center registerButton(RegisterBloc registerBloc) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: StreamBuilder(
            stream: registerBloc.registerValid,
            builder: (context, snapshot) {
              print("valid sayyy " + snapshot.hasData.toString());
              return IgnorePointer(
                ignoring: !snapshot.hasData,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: AppTheme.primaryColor)),
                  onPressed: () {
                    if (!firstTime){registerBloc.submitRegister(true);
                        firstTime=!firstTime;
                    Dialogs.showLoadingDialog(context);
                    }
                   
                  },
                  color: Colors.white,
                  textColor: Colors.grey[500],
                  child: Text(
                    'SignUp'.toUpperCase(),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Padding email(RegisterBloc registerBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: registerBloc.emailStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: registerBloc.changeEmail,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.verified_user,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'Email',
                hintText: 'Email adress',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Padding phoneNumber(RegisterBloc registerBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 24),
      child: StreamBuilder(
          stream: registerBloc.phoneNumberStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: registerBloc.changePhoneNumber,
              autocorrect: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.mobile_screen_share,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'Phone number',
                hintText: 'Phone number',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Padding password(RegisterBloc registerBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 0),
      child: StreamBuilder(
          stream: registerBloc.passwordStream,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
              onChanged: registerBloc.changePassword,
              decoration: InputDecoration(
                hintText: 'password',
                icon: Icon(
                  Icons.vpn_key,
                  color: snapshot.hasError
                      ? AppTheme.redText
                      : AppTheme.primaryColor,
                ),
                errorText: snapshot.error,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            );
          }),
    );
  }

  Padding confrimPassword(RegisterBloc registerBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 0),
      child: StreamBuilder(
          stream: registerBloc.conforimPasswordStream,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
              onChanged: registerBloc.changeConfirmPassword,
              decoration: InputDecoration(
                hintText: 'Confrim Password',
                icon: Icon(
                  Icons.repeat,
                  color: snapshot.hasError
                      ? AppTheme.redText
                      : AppTheme.primaryColor,
                ),
                errorText: snapshot.error,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide:
                      BorderSide(color: AppTheme.primaryColor, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            );
          }),
    );
  }
}


class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child:  SpinKitWave(
    color: AppTheme.primaryColor,
    size: 120.0,
  )
              ));
        });
  }
}
