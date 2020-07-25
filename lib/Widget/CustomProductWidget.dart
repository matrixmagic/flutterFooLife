import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/MenuBar.dart';

import 'package:foolife/Widget/stories_bar.dart';
import 'package:video_player/video_player.dart';

import 'custom_buttom_navigatior.dart';
import 'my_flutter_app_icons.dart';


class CustomProductWidget extends StatefulWidget{
  String backgroundImage;
  ProductDto product;
  int  restaurantid;
    String extention;
  CustomProductWidget({this.backgroundImage,this.product,this.restaurantid,this.extention});

  @override
  _CustomProductWidgetState createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {

 VideoPlayerController _controller;

   @override
  void initState() {
    super.initState();
    if(widget.extention=="mp4"){
    _controller = VideoPlayerController.network(
       widget.backgroundImage)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
       
      });

       _controller.setVolume(0.0);
       _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.backgroundImage);
     print(widget.product.name);
     print(widget.extention);
    return SafeArea(
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: widget.extention!="mp4"? Image(
              image:  NetworkImage(widget.backgroundImage),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fitHeight,
            ):
            Center(
          child: _controller !=null ?  VideoPlayer(_controller)
              : Container(),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     setState(() {
        //       _controller.value.isPlaying
        //           ? _controller.pause()
        //           : _controller.play();
        //     });
        //   },
        //   child: Icon(
        //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        //   ),
        // ),
            
          ),
          Positioned(left: 20,top: 10, child: Text(widget.product.category.name, style: TextStyle(fontSize: 20,color: AppTheme.notWhite ,fontFamily:"SpecialElite" ))),
        
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:[ Column(
                      children: <Widget>[
                        Text(
                          widget.product.name,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: <Widget>[
                            Text((widget.product.price.toString()+"\$".toString()),style: TextStyle(color: Colors.white, fontSize: 20)),
                            Icon(Icons.info_outline ,color: Colors.white ,size: 24, ),
                          ],
                        )
                      ],
                    ),
                    ]
                  ),
                  padding: EdgeInsets.only(
                    top: 30,
                    right: 10
                  ),
                )
              ],
            ),
          ),
         

      
 Padding(
            padding: EdgeInsets.only( top: MediaQuery.of(context).size.height/5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text(
                        '22',style: TextStyle(color:Colors.white.withOpacity(0.8) ),
                        
                      )
                    ],
                  ),
                ),
               
                Container(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22',style: TextStyle(color:Colors.white.withOpacity(0.8)  ))
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22', style: TextStyle(color:Colors.white.withOpacity(0.8) ))
                    ],
                  ),
                ),
                
                Container(
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                         Icons.insert_comment,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22' ,style: TextStyle(color:Colors.white.withOpacity(0.8) ))
                      
                    ],
                  ),
                ),
                
                
              ],
            ),
          ),
          

      
      
      
        ]),


        
      ),
    );
  }
}
