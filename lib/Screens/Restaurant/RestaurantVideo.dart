import 'package:flutter/material.dart';
import '../../AppTheme.dart';

class RestaurantVideo extends StatefulWidget {
  @override
  _RestaurantVideoState createState() => _RestaurantVideoState();
}

class _RestaurantVideoState extends State<RestaurantVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            'sat',
            style: AppTheme.body1,
          ),
          Text(
            'sun',
            style: AppTheme.body1,
          ),
          Text(
            'mon',
            style: AppTheme.body1,
          ),
          Text(
            'thus',
            style: AppTheme.body1,
          ),
          Text(
            'wed',
            style: AppTheme.body1,
          ),
          Text(
            'thur',
            style: AppTheme.body1,
          ),
          Text(
            'fri',
            style: AppTheme.body1,
          ),
        ],
      ),
    );
  }
}
