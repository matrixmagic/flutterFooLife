import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';
import 'package:foolife/Widget/stories_bar.dart';


class MainScreen extends StatelessWidget {
  @override
 var  images =['assets/images/Restaurant1.jpg','assets/images/Restaurant2.jpg','assets/images/Restaurant3.jpg'];
var names=['KFC','Pizza Hut','McDonald'];
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  Stack(
          children: <Widget>[
           
            Swiper(
  itemBuilder: (BuildContext context, int index) {
    return CustomMainScreenWiget(backgroundImage: images[index],restauranName: names[index],);
  },
  itemCount: 3,
  
  scrollDirection:Axis.vertical ,
  scale: 1.0,
),Positioned(bottom: 0 ,left: 5.0,right: 5.0,child: CustomButtomNavigatior(),),
       ],
        )
        
      ),
    );
  }
}
