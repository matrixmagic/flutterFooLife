import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foolife/Bloc/AuthBloc.dart';
import 'package:foolife/Bloc/auth/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';


 
class UserSignup extends StatefulWidget {
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  File imageFile;
  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
 final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
              child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 24),
                  child: Stack(
                    children: <Widget>[

                   imageFile==null ? Image.asset('assets/images/Avatar.png' , height:275  ,width:MediaQuery.of(context).size.width ,fit: BoxFit.fill, ):Image.file(imageFile,height: 250,fit: BoxFit.cover,),
                      Positioned(
                        child: GestureDetector(onTap: ()=>  _showSelectionDialog(context) ,
                                                child: Container(
                            width: 60,
                            height: 60,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60.0)),color: Colors.black),
                              child: Icon(
                            Icons.camera_alt,
                            color: AppTheme.nearlyWhite,
                            size: 30,
                          )),
                        ),
                        bottom: 5,
                        right: 5,
                      )
                    ],
                  )),
             
              StreamBuilder(
            
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    if (snapshot2.data == true) {
                      Navigator.pushNamed(context, '/usersignup');
                    } else {
                      return Text('invalid username or password',
                          style: AppTheme.error);
                    }
                  
                  }
                  return Container();
                },
              ),
              email(authBloc),
              password(authBloc),
              confrimPassword(authBloc),
               Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("    Register As",style: AppTheme.body1,),SizedBox(width: 35,),
                  LiteRollingSwitch(
                    value: true,
                    textOn: 'Restaurant',
                    textOff: 'Customer',
                    colorOn: AppTheme.primaryColor,
                    colorOff: AppTheme.primaryColor,
                    iconOn: Icons.restaurant_menu,
                    iconOff: Icons.person_outline,
                    onChanged: (bool state) {
                      print('turned ${(state) ? 'on' : 'off'}');
                    },
                  ),
                ],
              ),),
              SizedBox(
                height: 20,
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

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
             
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[

                    ListTile(leading: Icon(Icons.image,color: AppTheme.primaryColor,),title: Text("Gallery"),onTap: () {
                        _openGallery(context);
                      },),
                      Divider(height: 1.0,),
                       ListTile(leading: Icon(Icons.camera_alt,color: AppTheme.primaryColor,),title: Text("Camera"),onTap: () {
                        _openCamera(context);
                      },)
                  
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
 final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);

  registerBloc.changeFile(picture);


    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);

   final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);

  registerBloc.changeFile(picture);
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile);
    } else {
      return Text("Please select an image");
    }
  }

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
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
    );
  }

  Center registerButton(RegisterBloc registerBloc) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: 
               RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: AppTheme.primaryColor)),
                onPressed: () {
                  registerBloc.registerPressed(true);
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
      ),
    );
  }

  Padding email(AuthBloc authBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
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
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 0),
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
Padding confrimPassword(AuthBloc authBloc) {
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
