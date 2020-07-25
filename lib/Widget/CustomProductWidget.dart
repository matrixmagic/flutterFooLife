import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/MenuBar.dart';

import 'package:foolife/Widget/stories_bar.dart';
import 'package:video_player/video_player.dart';


class CustomProductWidget extends StatefulWidget{
  String backgroundImage;
  String productName;
  int  restaurantid;
    String extention;
  CustomProductWidget({this.backgroundImage,this.productName,this.restaurantid,this.extention});

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
     print(widget.productName);
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
          child: _controller !=null  ? AspectRatio(
                  aspectRatio: 9 / 16,
                  child: VideoPlayer(_controller),
                )
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
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                
                  child: Center(
                    child: Text(
                      widget.productName,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 60,
                  ),
                )
              ],
            ),
          ),
         

          
      FutureBuilder(
        future: RestaurantRepository().getRestrantCategory(widget.restaurantid),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          return Positioned(bottom:70 , child: Container(height:40 ,width: 500,child: MenuBar(items:snapshot.data ,) ));
          }
          else
          return Container();
        }
      ),
        ]),


        
      ),
    );
  }
}
