import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoProductView extends StatefulWidget {
  File video;
  VideoProductView(this.video){
    print(video.path);

  }
  @override
  _VideoProductViewState createState() => _VideoProductViewState();
}

class _VideoProductViewState extends State<VideoProductView> {



  @override
  



  VideoPlayerController _controller;


didUpdateWidget(VideoProductView oldWidget){

 if(widget.video!=oldWidget.video){
 _controller = VideoPlayerController.file(widget.video
      )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {


        });
       
      });

       _controller.setVolume(0.0);
       _controller.play();

 }

}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _controller = VideoPlayerController.file(widget.video
      )
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {


        });
       
      });
      print("sadasadsasd  iniitttttttttttttttttttt");

       _controller.setVolume(0.0);
       _controller.play();
      
  }
  @override
  Widget build(BuildContext context) {
    return _controller !=null  ?  VideoPlayer(_controller): Container();
  }
}