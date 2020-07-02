import 'package:flutter/material.dart';

class LikesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '200k ',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              Text('Likes',
                  style: TextStyle(color: Colors.red, fontSize: 25))
            ],
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
                          Container(child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[ Padding(
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
                          ),Text('Italian burger')],),
                                    
                          ),
                          Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                            Icon(Icons.favorite,color: Colors.red,),
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
                            ),Text('lucas')
                          ],),),
                          Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[Text('21/2/2020'),Text('23:40')],),)
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
