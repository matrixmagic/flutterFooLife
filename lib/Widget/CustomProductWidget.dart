import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/ProductExtraDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:pedantic/pedantic.dart';
import 'package:foolife/Widget/stories_bar.dart';
import 'package:video_player/video_player.dart';

import 'custom_buttom_navigatior.dart';
import 'my_flutter_app_icons.dart';

class CustomProductWidget extends StatefulWidget {
  String backgroundImage;
  ProductDto product;
  int restaurantid;
  String extention;
  CustomProductWidget(
      {this.backgroundImage, this.product, this.restaurantid, this.extention});

  @override
  _CustomProductWidgetState createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  // VideoPlayerController _controller;
  BetterPlayerController _betterPlayerController;
  bool boolInfo = false;
  bool detailsInfo = false;
  DefaultCacheManager _cacheManager;
  @override
  Future<void> initState() {
    super.initState();
    _cacheManager = DefaultCacheManager();
    if (widget.extention == "mp4") {
      print(widget.backgroundImage);
      getVideoController();
      /*   _controller = VideoPlayerController.network(widget.backgroundImage)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      _controller.setLooping(true);
      _controller.setVolume(0.0);
      _controller.play();*/
    }
  }

  void getVideoController() async {
    double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    double _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
    var x = await getControllerForVideo(
        widget.product.file.path, _screenWidth, _screenHeight);
    setState(() {
      _betterPlayerController = x;
    });
  }

  Future<BetterPlayerController> getControllerForVideo(
      String videoUrl, double _screenWidth, double _screenHeight) async {
    final fileInfo = await _cacheManager.getFileFromCache(videoUrl);

    if (fileInfo == null || fileInfo.file == null) {
      print('[VideoControllerService]: No video in cache');

      print('[VideoControllerService]: Saving video to cache');
      unawaited(_cacheManager.downloadFile(videoUrl));

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.NETWORK,
        videoUrl,
        liveStream: true,
      );
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          aspectRatio: _screenWidth / _screenHeight,
          controlsConfiguration: BetterPlayerControlsConfiguration(
              liveText: "", showControls: false),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      _betterPlayerController.setVolume(0.0);

      return _betterPlayerController;
    } else {
      print('[VideoControllerService]: Loading video from cache');

      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.FILE,
        fileInfo.file.path,
        liveStream: true,
      );
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          aspectRatio: _screenWidth / _screenHeight,
          controlsConfiguration: BetterPlayerControlsConfiguration(
              liveText: "", showControls: false),
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );

      _betterPlayerController.setVolume(0.0);
      return _betterPlayerController;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.backgroundImage);
    print(widget.product.name);
    print(widget.extention);
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: widget.extention != "mp4"
                ? CachedNetworkImage(
                    imageUrl: widget.backgroundImage,
                    height: MediaQuery.of(context).size.height,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
                    fit: BoxFit.cover,
                  )
                : _betterPlayerController != null
                    ? Container(
                        child: BetterPlayer(
                          controller: _betterPlayerController,
                        ),
                      )
                    : Container(),
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
          GestureDetector(
            onTap: () {
              setState(() {
                detailsInfo = false;
                boolInfo = false;
              });
            },
            child: Expanded(
                child: Container(
              color: Colors.blue.withOpacity(0),
            )),
          ),
          Positioned(
              left: 20,
              top: 30,
              child: Text(widget.product.category.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.notWhite,
                      fontFamily: "SpecialElite"))),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 40.0,
                              spreadRadius: 1.0,
                            ),
                          ]),
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: "SpecialElite"),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.7),
                                    blurRadius: 40.0,
                                    spreadRadius: 1.0,
                                  ),
                                ]),
                                child: Text(
                                    (widget.product.price.toString() +
                                        "\$".toString()),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "SpecialElite")),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.7),
                                    blurRadius: 40.0,
                                    spreadRadius: 1.0,
                                  ),
                                ]),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        boolInfo = !boolInfo;
                                        if (boolInfo) {
                                          detailsInfo = false;
                                        }
                                      });
                                    },
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                  padding: EdgeInsets.only(top: 30, right: 10),
                )
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ]),
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.favorite,
                            size: 31,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Text(
                        '22',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 40.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.person,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 40.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.share,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 40.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.insert_comment,
                          size: 31,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          boolInfo
              ? Padding(
                  padding: EdgeInsets.only(
                      left: 50,
                      right: 50,
                      bottom: (MediaQuery.of(context).size.height / 2),
                      top: 100),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black.withOpacity(0.4)),
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            widget.product.content != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          widget.product.content,
                                          style: TextStyle(
                                              color: AppTheme.notWhite,
                                              fontSize: 18,
                                              fontFamily: "SpecialElite"),
                                          textAlign: TextAlign.center,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                      ),
                                      widget.product.price != null
                                          ? Text(
                                              widget.product.price == null
                                                  ? " "
                                                  : widget.product.price
                                                      .toString(),
                                              style: TextStyle(
                                                  color: AppTheme.notWhite,
                                                  fontFamily: "SpecialElite",
                                                  fontSize: 18))
                                          : SizedBox()
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            widget.product.productExtra.length > 0 &&
                                    widget.product.productExtra[0].name != null
                                ? Container(
                                    color: Colors.white,
                                    height: 1,
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 5,
                            ),
                            Column(
                              children:
                                  getExtraProduct(widget.product.productExtra),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          Positioned(
            right: 5.0,
            bottom: 90,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 40.0,
                  spreadRadius: 1.0,
                ),
              ]),
              child: IconButton(
                icon: Icon(
                  Icons.info,
                  color: AppTheme.notWhite.withOpacity(0.7),
                ),
                onPressed: () {
                  setState(() {
                    detailsInfo = !detailsInfo;
                    if (detailsInfo) {
                      boolInfo = false;
                    }
                  });
                },
              ),
            ),
          ),
          detailsInfo
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black.withOpacity(0.4)),
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: 1200,
                        width: 600,
                        child: Text(
                          widget.product.details == null
                              ? " "
                              : widget.product.details,
                          style: TextStyle(
                              color: AppTheme.notWhite,
                              fontSize: 15,
                              fontFamily: "SpecialElite"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              : Container()
        ]),
      ),
    );
  }

  List<Widget> getExtraProduct(List<ProductExtraDto> productExtraDto) {
    return productExtraDto.map((e) {
      if (e.name == null) {
        return Container();
      } else
        return Row(
          children: <Widget>[
            Text(e.name,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "SpecialElite")),
            SizedBox(
              width: 5,
            ),
            e.price != null
                ? Text(e.price,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: "SpecialElite"))
                : SizedBox()
          ],
        );
    }).toList();
  }
}

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(size.width / 1.12, 0);
    path.lineTo(size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BorderPainter extends CustomPainter {
  //         <-- CustomPainter class
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = AppTheme.notWhite;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 1;

    var path = Path();
    path.moveTo(size.width / 1.12, 0);
    path.cubicTo(size.width, -5, size.width, -20, size.width, -15);
    path.lineTo(size.width, 10);

    canvas.drawPath(path, paint);

    //canvas.drawPoints(pointMode, points, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
