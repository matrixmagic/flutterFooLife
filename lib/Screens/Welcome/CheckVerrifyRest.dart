import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/Bloc/AuthBloc.dart';
import 'package:foolife/Bloc/auth/Register/CheckVerfiy/VerfiyBloc.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/provider.dart';

import '../../AppLocalizations.dart';
import '../../AppTheme.dart';

class CheckVerrifyRest extends StatefulWidget {
  @override
  _CheckVerrifyRestState createState() => _CheckVerrifyRestState();
}

class _CheckVerrifyRestState extends State<CheckVerrifyRest> {
  @override
  bool firstTime = false;
  Widget build(BuildContext context) {

    final VerfiyBloc verfiyBloc = new VerfiyBloc();
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
         Text('Please use your e-mail adress from your official Website',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
         
            StreamBuilder(
              stream: verfiyBloc.submitverfiedStream,
              builder: (context, snapshot2) {
                if (snapshot2.hasData) {
                  if (snapshot2.data == 412) {
                   
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context)
                            .pushReplacementNamed('/mainscreen');
                      });
                    
                  }
                  else if (snapshot2.data==411)
                  {
                    return Text('email is  already verfied',style: AppTheme.error);
                  }
                   else {
                    return Text('not exists email',
                        style: AppTheme.error);
                  }
                  print("server say  " + snapshot2.data.toString());
                }
                return Container();
              },
            ),
            email(verfiyBloc),
    SizedBox(height:40),
 RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(50.0),
                      side: BorderSide(color: AppTheme.primaryColor)),
                  onPressed: () {
                    print('im pressed verfiy');
                  verfiyBloc.changeActive(1);
                  },
                  color: Colors.green,
                  textColor: Colors.grey[500],
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('verfiy')
                        ,
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
          SizedBox(height:60),
           
            
           // register(context),
           
            Container(height: 60,width: 60,
            color: Colors.blue,),
            Text('als user registeration',style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,)),
            SizedBox(height:20),
            GestureDetector(child: Text('Register',style: TextStyle(fontSize: 24,decoration: TextDecoration.underline,),
            ),onTap:(){ Navigator.of(context).pushNamed('/usersignup'); },),
            SizedBox(height:25),
            Text('Impressum',style: TextStyle(fontSize: 22,decoration: TextDecoration.underline,))
          ],
        ),
      ),
    );
  }


  Padding email(VerfiyBloc verfiyBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35.0, 13, 35, 13),
      child: StreamBuilder(
          stream: verfiyBloc.emailStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: verfiyBloc.changeEmail,
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
                   
                  ),
                ),
              ),
            );
          }),
    );
  }

 
  
}
