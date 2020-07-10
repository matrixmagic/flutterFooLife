import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/Bloc/AuthBloc.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  bool firstTime = false;
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 100, 35, 24),
              child: Icon(
                Icons.account_circle,
                size: 125.0,
                color: AppTheme.primaryColor,
              ),
            ),
            StreamBuilder(
              stream: authBloc.loginstream,
              builder: (context, snapshot2) {
                if (snapshot2.hasData) {
                  if (snapshot2.data == true) {
                    if (!firstTime) {
                      firstTime = true;

                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context)
                            .pushReplacementNamed('/mainscreen');
                      });
                    }
                  } else {
                    return Text('invalid username or password',
                        style: AppTheme.error);
                  }
                  print("server say  " + snapshot2.data.toString());
                }
                return Container();
              },
            ),
            email(authBloc),
            password(authBloc),
            SizedBox(
              height: 20,
            ),
            loginButton(authBloc),
            register(context),
            forgotPassword(context)
          ],
        ),
      ),
    );
  }

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/usersignup');
      },
      child: Text(
        "Forgot your password?",
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontWeight: FontWeight.w400,
          fontSize: 20,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Row register(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account",
          style: AppTheme.body1,
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/usersignup');
          },
          child: Text(
            'Register Now!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 0.2,
            ),
          ),
        ),
        SizedBox(
          height: 60,
        )
      ],
    );
  }

  Center loginButton(AuthBloc authBloc) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: StreamBuilder(
            stream: authBloc.submitValid,
            builder: (context, snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.hasData,
                child: RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: AppTheme.primaryColor)),
                  onPressed: () {
                    authBloc.loginpress(true);
                  },
                  color: Colors.white,
                  textColor: Colors.grey[500],
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('login')
                        .toUpperCase(),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Padding email(AuthBloc authBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 24),
      child: StreamBuilder(
          stream: authBloc.Emailstream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: authBloc.changeEmail,
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

  Padding password(AuthBloc authBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 24),
      child: StreamBuilder(
          stream: authBloc.passstream,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
              onChanged: authBloc.changepass,
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
}
