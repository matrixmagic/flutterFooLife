import 'package:flutter/material.dart';

class ViewersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '263k ',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 25),
                ),
                Text('Viewers',
                    style: TextStyle(color: Colors.greenAccent, fontSize: 25))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(),
                SizedBox(),
                Text('duration'),
                Text('date'),
                Text('time'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    "assets/images/person.png",
                                    fit: BoxFit.fill,
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('johny'),
                          )
                        ],
                      ),
                      Text('2 min 8 sec'),
                      Text('21/2/2020'),
                      Text('23:40')
                    ],
                  )),
                );
              },
              itemCount: 15,
            ),
          )
        ],
      ),
    );
  }
}
