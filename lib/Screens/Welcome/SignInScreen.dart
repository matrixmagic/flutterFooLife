import 'package:flutter/material.dart';
import 'package:foolife/Bloc/AuthBloc.dart';
import 'package:foolife/Bloc/provider.dart';

import '../../AppTheme.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
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
                    Navigator.pushNamed(context, '/usersignup');
                  } else {
                    return Text(
                      'invalid username or password',
                      style: AppTheme.body1,
                    );
                  }
                  print("server say  " + snapshot2.data.toString());
                }
                return Container();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 30, 30, 24),
              child: StreamBuilder(
                  stream: authBloc.Emailstream,
                  builder: (context, snapshot) {
                    return TextField(
                      onChanged: authBloc.changeEmail,
                      autocorrect: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.verified_user),
                        errorText: snapshot.error,
                        labelText: 'Email',
                        hintText: 'Email adress',
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: AppTheme.primaryColor, width: 2),
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
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 22, 30, 24),
              child: StreamBuilder(
                  stream: authBloc.passstream,
                  builder: (context, snapshot) {
                    return TextField(
                      obscureText: true,
                      autocorrect: true,
                      onChanged: authBloc.changepass,
                      decoration: InputDecoration(
                        hintText: 'password',
                        icon: Icon(Icons.vpn_key),
                        errorText: snapshot.error,
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(
                              color: AppTheme.primaryColor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
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
                            "Login".toUpperCase(),
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Row(
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
                    Navigator.pushNamed(context, '/restsignup');
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/usersignup');
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
            )
          ],
        ),
      ),
    );
  }
}
