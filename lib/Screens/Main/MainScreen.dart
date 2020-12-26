import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';

class MainScreen extends StatefulWidget {
  @override
  int goToThisRestaurantId;

  MainScreen({this.goToThisRestaurantId});

  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int lastindex;
  List<BetterPlayerController> myRestVedio;
  List<RestaurantDto> myRest;
  @override
  void initState() {
    lastindex = 0;
    // TODO: implement initState
    super.initState();
    getRest();
    myRestVedio = new List<BetterPlayerController>();
  }

  getRest() {
    print("start get resturant");
    getRest2();
  }

  int currentVideoToInt = 0;
  int lastVideoTOInt = 5;
  int currentPlayVedio = 0;

   BetterPlayerController intVideo(int idVideo, bool down, bool re) {
    print("stat inint ver n " + idVideo.toString());
    BetterPlayerController _betterPlayerController;
    var file = myRest[idVideo].file;
    bool isVideo = file.extension == "m3u8";
    double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    double _screenHeight = WidgetsBinding.instance.window.physicalSize.height;

    if (isVideo) {
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.NETWORK, file.path,
          cacheConfiguration: BetterPlayerCacheConfiguration(useCache: true)
          // liveStream: true,
          );
       _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          aspectRatio: _screenWidth / _screenHeight,
          controlsConfiguration: BetterPlayerControlsConfiguration(
            enableProgressBar: true,
            showControls: false,
          ),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      _betterPlayerController.setVolume(100);
      print(
          " tryyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy,yyyyyyyy Listnerrr is calllllllllllllllllllllllllllllllll ");
      _betterPlayerController.addListener(() {
        print("Listnerrr is calllllllllllllllllllllllllllllllll ");
        if (_betterPlayerController.isVideoInitialized()) {
          print("enteeeeeeeeeeeeeeeer isVideoInilializeddddddddddd");
          _betterPlayerController.pause();
          if (re == true){
           return _betterPlayerController;
          
          }
          else {
            if (down) {
              myRestVedio.add(_betterPlayerController);
              newVedio();
            } else {
              myRestVedio.insert(0, _betterPlayerController);
              newVedio();
            }
          }
        }
      });
    } else {
      myRestVedio.add(null);
      newVedio();
    }

    return _betterPlayerController;
  }

  newVedio() {
    setState(() {
      currentVideoToInt++;
      print("new state ");
    });
    if (currentVideoToInt <= lastVideoTOInt)
      intVideo(currentVideoToInt, true, false);
  }

  getRest2() async {
    var x = await RestaurantRepository().getAllResturantPaging2([], 10);

    print("finish get resturant");
    myRest = x;

    intVideo(currentVideoToInt, true, false);
  }

  @override
  Widget build(BuildContext context) {
    return myRest == null
        ? Container(
            color: Colors.blue,
          )
        : Swiper(
            loop: false,
            itemCount: myRest.length,
            scrollDirection: Axis.vertical,
            onIndexChanged: (index) {
         

              

              if (lastindex < index) {
                if(currentPlayVedio>=0)
                myRestVedio[currentPlayVedio] = intVideo(index-1, true, true);
                setState(() {
                  currentPlayVedio++;
                  
                });
              }
              else {
                if(currentPlayVedio<myRestVedio.length)
                myRestVedio[currentPlayVedio] = intVideo(index+1, true, true);
                setState(() {
                  currentPlayVedio--;
                });

              }
              lastindex = index;
            },
            itemBuilder: (BuildContext context, int index) {
              var isVedio = myRest[index].file.extension == "m3u8" ||
                  myRest[index].file.extension == "mp4";

              if (!isVedio) {
                return CachedNetworkImage(
                  imageUrl: myRest[index].file.path,
                  height: WidgetsBinding.instance.window.physicalSize.height,
                  width: WidgetsBinding.instance.window.physicalSize.width,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  fit: BoxFit.cover,
                );
              } else if (index >= myRestVedio.length)
                return Container(
                  color: Colors.green,
                  child: Center(child: CircularProgressIndicator()),
                );
              else if (isVedio && myRestVedio == null)
                return Container(
                  color: Colors.purple,
                  child: Center(child: CircularProgressIndicator()),
                );
              else if (myRestVedio[index] == null)
                return Container(
                  color: Colors.brown,
                  child: Center(child: CircularProgressIndicator()),
                );
              //     else if(   !myRestVedio[index].isVideoInitialized()){
              //   return Container(color: Colors.grey,
              //   child: Center(child: CircularProgressIndicator()),);

              // }
              else if (isVedio &&
                  myRestVedio != null &&
                  myRestVedio[index] != null &&
                  myRestVedio[index].isVideoInitialized()) {
                return videoBika(
                  index: index,
                  videoController: myRestVedio[index],
                );
              } else {
                return CachedNetworkImage(
                  imageUrl: myRest[index].file.path,
                  height: WidgetsBinding.instance.window.physicalSize.height,
                  width: WidgetsBinding.instance.window.physicalSize.width,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  fit: BoxFit.cover,
                );
              }
            },
          );
  }
}

class videoBika extends StatefulWidget {
  @override
  int index;
  BetterPlayerController videoController;
  videoBika({this.index, this.videoController});

  _videoBikaState createState() => _videoBikaState();
}

class _videoBikaState extends State<videoBika> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playVideo();
    f = false;
  }

  bool f;
  Future<void> playVideo() async {
    await widget.videoController.play();
    print('plaaaaaaaaaaaaaaaaaaaaaaaaaaaayyyyy');
    setState(() {
      f = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(
      controller: widget.videoController,
    );
  }

  @override
  Future<void> dispose() async {
    // TODO: implement dispose

    print('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
    await widget.videoController.pause();

    widget.videoController = null;
    print('sssssssssssssssssssssssssssssssssss');
    super.dispose();
  }
}
