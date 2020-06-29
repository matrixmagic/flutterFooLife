import 'dart:async';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';

class VideoSplashScreen1 extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoSplashScreen1> {
  VideoPlayerController playerController;
  VoidCallback listener;
  FlutterSecureStorage storage;

  @override
  @override
   initState()  {
    super.initState();
   
    listener = () {
      setState(() {});
    };
    initializeVideo();
    

    ///video splash display only 5 second you can change the duration according to your need
     startTime();
  }

  startTime() async {

      storage = new FlutterSecureStorage();
  var _firstTime = await storage.read(key: "_firstTime");
    var _duration = new Duration(seconds: _firstTime==null?14:7);
    return new Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);

     final storage = new FlutterSecureStorage();
         await storage.write(key: "_firstTime", value:"true");
       
        Navigator.of(context).pushReplacementNamed('/mainscreen');
    
    
   
  }

  Future<void> initializeVideo() async {

 var   storage = new FlutterSecureStorage();
     var _firstTime = await storage.read(key: "_firstTime");
     var video=_firstTime==null?"assets/videos/splash1.mp4":"assets/videos/splash2.mp4";

    playerController =
        VideoPlayerController.asset(video)
          ..addListener(listener)
          ..setVolume(1.0)
          ..initialize()
          ..play();
          playerController.play();
  }

  @override
  void deactivate() {
    if (playerController != null) {
      playerController.setVolume(0.0);
      playerController.removeListener(listener);
    }
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (playerController != null) playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      new AspectRatio(
          aspectRatio: 9 / 16,
          child: Container(
            child: (playerController != null
                ? VideoPlayer(
                    playerController,
                  )
                : Container()),
          )),
    ]));
  }
}