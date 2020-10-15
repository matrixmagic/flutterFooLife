import 'package:flutter/material.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';

class PasswordSet extends StatefulWidget {
  @override
  _PasswordSetState createState() => _PasswordSetState();
}

class _PasswordSetState extends State<PasswordSet> {
  @override
  Widget build(BuildContext context) {
    final RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'insperry',
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Container(
              child: Text(
                'cafe extraplet',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 30),
            child: Text(
              'Welcome in insperry family!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, color: Colors.grey),
            ),
          ),
          password(registerBloc),
          confrimPassword(registerBloc),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 70,
              width: 250,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black12)),
                onPressed: () {
                  // Navigator.of(context).pushNamed('/PasswordSet');
                },
                color: Colors.white,
                textColor: Colors.grey[500],
                child: Text(
                  AppLocalizations.of(context).translate('save'),
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
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
                  color: snapshot.hasError ? AppTheme.redText : Colors.black,
                ),
                errorText: snapshot.error,
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
                  color: snapshot.hasError ? AppTheme.redText : Colors.black,
                ),
                errorText: snapshot.error,
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
            );
          }),
    );
  }
}
