import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Repository/AuthRepository.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';

class PasswordSet extends StatefulWidget {
  @override
  _PasswordSetState createState() => _PasswordSetState();
}

class _PasswordSetState extends State<PasswordSet> {
   var _contro1 = TextEditingController();
    var _contro = TextEditingController();
    int passwordlength=0;
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
              child: FutureBuilder(
                future: FlutterSecureStorage().read(key: "_restaurantName"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState==ConnectionState.done){
                  return Text(
                  snapshot.data,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  );
                  }else
                return  Container();
                }
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
          password(),
          confrimPassword(),
          passwordlength==1 ?
          Text('password must be at least 8 charcter'):
        passwordlength==2 ?
  Text('confirm password did not matched')
  : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              height: 70,
              width: 250,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: Colors.black12)),
                onPressed: () async {
                 
                 bool result=await AuthRepository().changeRestaurantPassword(_contro.value.text, _contro1.value.text);
                 if(result)
                  Navigator.of(context).pushNamed('/mainscreen');
                  else{

  if(_contro.value.text.length<8)
setState(() {
   passwordlength=1;
}); 
else setState(() {
   passwordlength=1;
}); 
                  }


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

  Padding password() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 0),
      child: StreamBuilder(
        
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
              controller: _contro ,
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

  Padding confrimPassword() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 22, 30, 0),
      child: StreamBuilder(
         
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              autocorrect: true,
         controller: _contro1,
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
