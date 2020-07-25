import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foolife/Bloc/auth/Register/RegisterBloc.dart';
import 'package:foolife/Bloc/auth/Register/ResturantRegistertionBloc.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Repository/PaymentRepository.dart';
import 'package:foolife/Screens/Welcome/UserSignup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../../AppTheme.dart';

class RetsturantSignup extends StatefulWidget {
  @override
  _RetsturantSignupState createState() => _RetsturantSignupState();
}

class _RetsturantSignupState extends State<RetsturantSignup> {
  bool firstTime = false;


  List _myActivities;


  String _myActivitiesResult;

  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';


  }

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final spinkit = SpinKitWave(
    color: AppTheme.primaryColor,
    size: 90.0,
  );

  @override
  Widget build(BuildContext context) {
    final ResturantRegistertionBloc resturantRegistertionBloc =
        BlocProvider.of<ResturantRegistertionBloc>(context);

    resturantRegistertionBloc.changeFile(null);
    resturantRegistertionBloc.changeAccessible(0);
    resturantRegistertionBloc.changeChildfriendly(0);
    resturantRegistertionBloc.changeGamepad(0);
    resturantRegistertionBloc.changeWifi(0);
    resturantRegistertionBloc.changePower(0);
    resturantRegistertionBloc.changePets(0);
    resturantRegistertionBloc.changePayments(null);
  

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 24),
                      child: Stack(
                        children: <Widget>[
                          StreamBuilder<Object>(
                              stream: resturantRegistertionBloc.fileStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.file(
                                    snapshot.data,
                                    height: 275,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  );
                                }
                                return Image.asset(
                                  "assets/images/Avatar.png",
                                  height: 275,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fill,
                                );
                              }),
                          Positioned(
                            child: GestureDetector(
                              onTap: () => _showSelectionDialog(context),
                              child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.0)),
                                      color: Colors.black),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: AppTheme.nearlyWhite,
                                    size: 30,
                                  )),
                            ),
                            bottom: 5,
                            right: 5,
                          ),
                          StreamBuilder<Object>(
                              stream: resturantRegistertionBloc.fileStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Positioned(
                                    child: GestureDetector(
                                      onTap: () {
                                        resturantRegistertionBloc
                                            .changeFile(null);
                                      },
                                      child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30.0)),
                                              color: Colors.black),
                                          child: Icon(
                                            Icons.close,
                                            color: AppTheme.nearlyWhite,
                                            size: 30,
                                          )),
                                    ),
                                    top: 5,
                                    right: 5,
                                  );
                                }
                                return Container();
                              }),
                        ],
                      )),
                   StreamBuilder(
                stream: resturantRegistertionBloc.submitRegisterStream,
                builder: (context, snapshot2) {
                  if (snapshot2.hasData) {
                    if (snapshot2.data == true) {
                      if (firstTime) {
                        print("Navigator goo go2");
          
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                      firstTime=!firstTime;
                          Navigator.of(context)
                              .pushReplacementNamed('/');
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
                  resturantName(resturantRegistertionBloc),
                  address(resturantRegistertionBloc),
                  city(resturantRegistertionBloc),
                  street(resturantRegistertionBloc),
                  fax(resturantRegistertionBloc),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 30.0, top: 30.0),
                    child: Row(
                      children: <Widget>[
                        opentime(resturantRegistertionBloc),
                        SizedBox(
                          width: 15,
                        ),
                        closetime(resturantRegistertionBloc),
                      ],
                    ),
                  ),
                  Wrap(
                    children: <Widget>[
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.accessibleStream,
                          builder: (context, snapshot)  {
                           
                            return IconButton(
                              icon: Icon(
                                Icons.accessible,
                                size: 38,
                                color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                              ),
                              onPressed: () {
                               
                                resturantRegistertionBloc.changeAccessible(snapshot.hasData ?snapshot.data==1? 0:1:null);
                              },
                            );
                          }),
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.childfriendlyStream,
                          builder: (context, snapshot) {
                            return IconButton(
                              icon: Icon(
                                Icons.child_friendly,
                                size: 38,
                                color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                              ),
                              onPressed: () {
 resturantRegistertionBloc.changeChildfriendly(snapshot.hasData ?snapshot.data==1? 0:1:null);
                              
                              },
                            );
                          }),
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.gamepadStream,
                          builder: (context, snapshot) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.gamepad,
                                  size: 38,
                                  color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                                ),
                                onPressed: () {
                                   resturantRegistertionBloc.changeGamepad(snapshot.hasData ?snapshot.data==1? 0:1:null);
                                },
                              ),
                            );
                          }),
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.wifiStream,
                          builder: (context, snapshot) {
                            return IconButton(
                              icon: Icon(
                                Icons.wifi,
                                size: 38,
                                color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                              ),
                              onPressed: () {
                                 resturantRegistertionBloc.changeWifi(snapshot.hasData ?snapshot.data==1? 0:1:null);
                              },
                            );
                          }),
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.powerStream,
                          builder: (context, snapshot) {
                            return IconButton(
                              icon: Icon(
                                Icons.power,
                                size: 38,
                                color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                              ),
                              onPressed: () {
                                 resturantRegistertionBloc.changePower(snapshot.hasData ?snapshot.data==1? 0:1:null);
                              },
                            );
                          }),
                      StreamBuilder<Object>(
                          stream: resturantRegistertionBloc.petsStream,
                          builder: (context, snapshot) {
                            return IconButton(
                              icon: Icon(
                                Icons.pets,
                                size: 38,
                                color: snapshot.hasData ?snapshot.data==1? AppTheme.primaryColor:null:null,
                              ),
                              onPressed: () { resturantRegistertionBloc.changePets(snapshot.hasData ?snapshot.data==1? 0:1:null);},
                            );
                          }),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      StreamBuilder<Object>(
                          stream: null,
                          builder: (context, snapshot) {
                            return Container(
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(22))),
                              child: DropdownButton<String>(
                                iconSize: 20,
                                hint: Text('hiii'),
                                items: <String>['A', 'B', 'C', 'D']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                            );
                          }),
                      Container(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                            child: FutureBuilder<Object>(
                              future: PaymentRepository().GetAll(),
                              builder: (context, snapshot) {
                                if(snapshot.connectionState ==ConnectionState.done){
                                return MultiSelectFormField(
                                  autovalidate: false,
                                  titleText: 'Payment',
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'Please select the type for your ';
                                    }
                                    return null;
                                  },
                                  dataSource: snapshot.data as List<dynamic>
                                  ,
                                  initialValue: _myActivities,
                                  textField: 'display',
                                  valueField: 'value',
                                  okButtonLabel: 'OK',
                                  cancelButtonLabel: 'CANCEL',
                                  // required: true,
                                  hintText: 'Please choose one or more',
                                  onSaved: (value) {
                                  List<int> lst= new List<int>();
                                  for (var item in value) {
                                    lst.add(item);
                                  }
                                    print(lst);
                                    
                                   resturantRegistertionBloc.changePayments(lst);
                                  },
                                );
                                }else{
                                  return Container();
                                }
                              }
                            ),
                          ),
                          Expanded(
                            child: MultiSelectFormField(
                              autovalidate: false,
                              titleText: 'payment',
                              validator: (value) {
                                if (value == null || value.length == 0) {
                                  return 'Please select the type for payment ';
                                }
                                return null;
                              },
                              dataSource: [
                                {
                                  "display": "American Express",
                                  "value": "American Express",
                                },
                                {
                                  "display": "Mastercard",
                                  "value": "Mastercard",
                                },
                                {
                                  "display": "Visa",
                                  "value": "Visa",
                                },
                                {
                                  "display": "Amazon",
                                  "value": "Amazon",
                                },
                                {
                                  "display": "Paybal",
                                  "value": "Paybal",
                                },
                                {
                                  "display": "Girocard",
                                  "value": "Girocard",
                                },
                                {
                                  "display": "EC",
                                  "value": "Ec",
                                },
                                {
                                  "display": "Bitcoin",
                                  "value": "Bitcoin",
                                },
                              ],
                              initialValue: _myActivities,
                              textField: 'display',
                              valueField: 'value',
                              okButtonLabel: 'OK',
                              cancelButtonLabel: 'CANCEL',
                              // required: true,
                              hintText: 'Please choose one or more methods',
                              onSaved: (value) {},
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  registerButton(resturantRegistertionBloc),
                  SizedBox(
                    height: 30,
                  ),
                ],
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
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Gallery"),
                  onTap: () {
                    _openGallery(context);
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Camera"),
                  onTap: () {
                    _openCamera(context);
                  },
                )
              ],
            ),
          ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    final ResturantRegistertionBloc resturantRegistertionBloc =
        BlocProvider.of<ResturantRegistertionBloc>(context);

    resturantRegistertionBloc.changeFile(picture);

    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);

    final ResturantRegistertionBloc resturantRegistertionBloc =
        BlocProvider.of<ResturantRegistertionBloc>(context);

    resturantRegistertionBloc.changeFile(picture);
    Navigator.of(context).pop();
  }

  Center registerButton(ResturantRegistertionBloc registerBloc) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 50,
        child: StreamBuilder(
             stream: registerBloc.registerValid,
            builder: (context, snapshot) {
          print("valid sayyy " + snapshot.hasData.toString());
          return IgnorePointer(
            ignoring: false,
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

  Padding resturantName(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: resturantRegistertionBloc.resturantNameStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeResturantName,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.restaurant_menu,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'Resturant name',
                hintText: 'Resturant name',
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

  Padding address(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: resturantRegistertionBloc.addressStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeAddress,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.location_searching,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'Address',
                hintText: 'Address',
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

  Padding city(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: resturantRegistertionBloc.cityStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeCity,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.location_city,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'City',
                hintText: 'City',
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

  Padding street(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: resturantRegistertionBloc.streetStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeStreet,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.streetview,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'street',
                hintText: 'street',
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

  Padding fax(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 30, 30, 0),
      child: StreamBuilder(
          stream: resturantRegistertionBloc.faxStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeFax,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.phone,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'fax',
                hintText: 'fax',
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

  Expanded opentime(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Expanded(
      child: StreamBuilder(
          stream: resturantRegistertionBloc.openTimeStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeOpenTime,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.timer,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'opentime',
                hintText: 'from',
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

  Expanded closetime(ResturantRegistertionBloc resturantRegistertionBloc) {
    return Expanded(
      child: StreamBuilder(
          stream: resturantRegistertionBloc.closeTimeStream,
          builder: (context, snapshot) {
            return TextField(
              onChanged: resturantRegistertionBloc.changeCloseTime,
              autocorrect: true,
              decoration: InputDecoration(
                icon: Icon(Icons.timer_off,
                    color: snapshot.hasError
                        ? AppTheme.redText
                        : AppTheme.primaryColor),
                errorText: snapshot.error,
                labelText: 'closetime',
                hintText: 'to',
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
}
