import 'dart:ui';

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
      appBar: AppBar(
        centerTitle:true ,
        title:Text('Registeration',style: TextStyle(color: Colors.purple),) ,
        backgroundColor: Colors.white
      ),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 25, 35, 10),
              child: Text(
                'Restaurant',style: TextStyle(fontSize: 18)
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
              height: 15,
            ),
            loginButton(authBloc),
             SizedBox(
              height: 15,
            ),
           // register(context),
            forgotPassword(context),
            Container(height: 60,width: 60,
            color: Colors.blue,),
            Text('als user registeration',style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,)),
            SizedBox(height:20),
            GestureDetector(child: Text('Register',style: TextStyle(fontSize: 24,decoration: TextDecoration.underline,),
            ),onTap:(){ Navigator.of(context).pushNamed('/CheckVerrifyRest'); },),
            SizedBox(height:25),
            Text('jgjgjggj',style: TextStyle(fontSize: 22,decoration: TextDecoration.underline,))
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
         
          fontWeight: FontWeight.w400,
          fontSize: 20,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  // Row register(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Text(
  //         "Don't have an account",
  //         style: AppTheme.body1,
  //       ),
  //       SizedBox(
  //         width: 10,
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).pushReplacementNamed('/usersignup');
  //         },
  //         child: Text(
  //           'Register Now!',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             color: AppTheme.primaryColor,
  //             fontWeight: FontWeight.w400,
  //             fontSize: 20,
  //             letterSpacing: 0.2,
  //           ),
  //         ),
  //       ),
  //       SizedBox(
  //         height: 60,
  //       )
  //     ],
  //   );
  // }

  Center loginButton(AuthBloc authBloc) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 40,
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
                  color: Colors.green,
                  textColor: Colors.grey[500],
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('log in')
                        ,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Padding email(AuthBloc authBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35.0, 13, 35, 13),
      child: StreamBuilder(
          stream: authBloc.Emailstream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: authBloc.changeEmail,
              autocorrect: true,
              decoration: InputDecoration(
                errorText: snapshot.error,
                labelText: 'Email',
                hintText: 'Email adress',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide:
                      BorderSide(color:Colors.black, width: 2),
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
      padding: EdgeInsets.fromLTRB(35.0, 10, 35, 13),
      child: StreamBuilder(
          stream: authBloc.passstream,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
              onChanged: authBloc.changepass,
              decoration: InputDecoration(
                hintText: 'password',
             
                errorText: snapshot.error,
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white70,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide:
                      BorderSide(color:Colors.black, width: 2),
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
