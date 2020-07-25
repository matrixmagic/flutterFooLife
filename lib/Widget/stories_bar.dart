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
                        padding: const EdgeInsets.all(4.0),
                      
                        
                    child: ClipRRect(
                     borderRadius: BorderRadius.circular(49.0),
                      child: Container(
                      width: 49.0,
                      height: 49.0,
                      decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white,width: 2),
                        
                          image: DecorationImage(
                             


                              image:  AssetImage(images[index],)
                            )
                          )
                        ),
                    ),
                      
                    ));
                  },
                ),
 
        );
  }
}

