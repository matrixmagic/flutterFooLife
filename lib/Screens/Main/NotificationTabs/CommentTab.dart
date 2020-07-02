import 'package:flutter/material.dart';

class CommentTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '100 ',
                style: TextStyle(color: Colors.cyan, fontSize: 25),
              ),
              Text('Comments',
                  style: TextStyle(color: Colors.cyan, fontSize: 25))
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
                                    border: Border.all(),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_up,
                                    size: 12,
                                  ),
                                  Text(
                                    '22',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Icon(
                                    Icons.thumb_down,
                                    size: 12,
                                  ),
                                  Text('22', style: TextStyle(fontSize: 12)),
                                  Icon(
                                    Icons.comment,
                                    size: 12,
                                  ),
                                  Text('22', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text('maxican burger'),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(40),
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          "assets/images/burger.jpeg",
                                          fit: BoxFit.fill,
                                        ))),
                              ),
                            ],
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
