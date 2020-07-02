import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComplaintsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.room_service,
                      size: 35,
                    ),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 14,
                    ),
                  ],
                ),
              ),
              Container(
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.fastfood,
                      size: 35,
                    ),
                    Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 14,
                    ),
                  ],
                ),
              ),
              Container(
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 35,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text("28"),
              Text("36"),
              Text("45"),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        //                    <-- BoxDecoration
                        border:
                            Border(bottom: BorderSide(color: Colors.grey[200])),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Container(
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                            "assets/images/person.png",
                                            fit: BoxFit.fill,
                                          ))),
                                ),
                                Text('Lucas')
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            30.0) //         <--- border radius here
                                        )),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "it's really tasty and the flavor was so nice as always ",
                                    style: TextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                          ),
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                            size: 35,
                          ),
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
