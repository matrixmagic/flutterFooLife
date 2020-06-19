import 'package:flutter/material.dart';

import '../../AppTheme.dart';

class EntreyScreen extends StatefulWidget {
  @override
  _EntreyScreenState createState() => _EntreyScreenState();
}

class _EntreyScreenState extends State<EntreyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120.0,
            ),
            Center(
              child: Icon(
                Icons.phone_iphone,
                size: 125.0,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
                child: Text(
              'welcome to Foollife',
              style: TextStyle(
                fontSize: 33.0,
                fontFamily: "OpenSans",
                color: AppTheme.primaryColor,
              ),
            )),
            SizedBox(
              height: 22.0,
            ),
            Text(
              'you already have an account??',
              style: AppTheme.body1,
            ),
            RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(66.0),
                  side: BorderSide(color: AppTheme.primaryColor)),
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              color: AppTheme.primaryColor,
              textColor: Colors.white,
              child: Text(
                "log in".toUpperCase(),
                style: TextStyle(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
                child: Text(
              'new to our app ?? sign up with few easy steps you can choose',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: "OpenSans",
                color: Colors.black45,
              ),
            )),
            SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: RaisedButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(66.0),
                        side: BorderSide(color: AppTheme.primaryColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/usersignup');
                    },
                    color: Colors.white,
                    textColor: Colors.grey[500],
                    child: Text(
                      "user".toUpperCase(),
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                RaisedButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(66.0),
                      side: BorderSide(color: AppTheme.primaryColor)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/restsignup');
                  },
                  color: Colors.white,
                  textColor: Colors.grey[500],
                  child: Text(
                    "resturant".toUpperCase(),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
