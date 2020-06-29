import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Screens/Main/story.dart';

class storiesBar extends StatefulWidget {
  @override
  _storiesBarState createState() => _storiesBarState();
}

class _storiesBarState extends State<storiesBar> {
  @override
  var images=['assets/images/Restaurant1.jpg','assets/images/Restaurant2.jpg','assets/images/Restaurant3.jpg','assets/images/Restaurant1.jpg','assets/images/Restaurant2.jpg','assets/images/Restaurant3.jpg','assets/images/Restaurant1.jpg','assets/images/Restaurant2.jpg','assets/images/Restaurant3.jpg','assets/images/Restaurant1.jpg'];
  Widget build(BuildContext context) {
    return Container(
      height: 60,
       child: ListView.builder(
                  
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                   

                    return GestureDetector(
                        onTap: ()=>  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Story()),
  ),
                                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                      
                        
                                                child: Container(
                            child: ClipRRect(child: Image.asset(images[index],height: 44, width: 44,fit: BoxFit.fill,),borderRadius: BorderRadius.circular(44),),
                          ),
                        ),
                      
                    );
                  },
                ),
 
        );
  }
}

