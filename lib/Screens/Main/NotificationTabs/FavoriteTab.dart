import 'package:flutter/material.dart';

class FavoriteTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '150K ',
                style: TextStyle(color: Colors.yellow, fontSize: 25),
              ),
              Text('Favorites',
                  style: TextStyle(color: Colors.yellow, fontSize: 25))
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
                          ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    "assets/images/person.png",
                                    fit: BoxFit.fill,
                                  ))),Text('Have added you as a favorite'),Text('21/2/2020'),Text('23:40')
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
