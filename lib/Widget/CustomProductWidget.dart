import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:foolife/AppTheme.dart';

import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/ProductExtraDto.dart';

import 'package:pedantic/pedantic.dart';

class CustomProductWidget extends StatefulWidget {
  bool isDrink;
  ProductDto product;
  bool forChannel;
  Function changeChannel;
  Function goToRestaurent;
  CustomProductWidget(
      {this.product,
      this.forChannel,
      this.changeChannel,
      this.isDrink,
      this.goToRestaurent});

  @override
  _CustomProductWidgetState createState() => _CustomProductWidgetState();
}

class _CustomProductWidgetState extends State<CustomProductWidget> {
  // VideoPlayerController _controller;
  BetterPlayerController _betterPlayerController;
  bool boolInfo = false;
  bool detailsInfo = false;
  DefaultCacheManager _cacheManager;
  double iconSize = WidgetsBinding.instance.window.physicalSize.height / 70;
  double iconContainerSpace =
      WidgetsBinding.instance.window.physicalSize.height / 62;
  double bottomSizeBox =
      WidgetsBinding.instance.window.physicalSize.height / 28;
  @override
  Future<void> initState() {
    super.initState();
    print(widget.product.name);
    _cacheManager = DefaultCacheManager();
    if (widget.product.file.extension == "mp4") {
      getVideoController();
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
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(children: <Widget>[
          Container(
            child: widget.product.file.extension != "mp4"
                ? CachedNetworkImage(
                    imageUrl: widget.product.file.path,
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
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                detailsInfo = false;
                boolInfo = false;
              });
            },
            child: Container(
              color: Colors.blue.withOpacity(0),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              heightFactor: 2,
              child: Text(
                widget.product.restaurantDto.name,
                style: TextStyle(
                    color: Colors.white, fontSize: 22, fontFamily: "calibril"),
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height:
                          WidgetsBinding.instance.window.physicalSize.height /
                              9,
                    ),
                    Container(
                      height: iconContainerSpace + 5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.favorite,
                          size: iconSize,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      width: 45,
                      child: Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: "SpecialElite"),
                        ),
                      ),
                    ),
                    Container(
                      height: iconContainerSpace,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: iconSize,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      width: 45,
                      child: Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: "SpecialElite"),
                        ),
                      ),
                    ),
                    Container(
                      height: iconContainerSpace,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.share,
                          size: iconSize,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      width: 45,
                      child: Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: "SpecialElite"),
                        ),
                      ),
                    ),
                    Container(
                      height: iconContainerSpace + 5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.insert_comment,
                          size: iconSize,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      width: 45,
                      child: Center(
                        child: Text(
                          '22',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontFamily: "SpecialElite"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 65,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
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
                                fontFamily: "calibril"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                    widget.product.price != null
                                        ? (widget.product.price.toString() +
                                            "\$".toString())
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "SpecialElite")),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              widget.product.details == null ||
                                      widget.product.details == "" ||
                                      widget.product.details == " "
                                  ? Container()
                                  : Container(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                    ),
                    widget.forChannel
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                height: iconContainerSpace,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.7),
                                      blurRadius: 40.0,
                                      spreadRadius: 1.0,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    widget.goToRestaurent
                                        .call(widget.product.restaurantId);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_return,
                                    size: iconSize * 1.2,
                                    color: AppTheme.notWhite.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          height: iconContainerSpace,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.7),
                                blurRadius: 40.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                detailsInfo = !detailsInfo;
                                if (detailsInfo) {
                                  boolInfo = false;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.info,
                              size: iconSize * 1.2,
                              color: AppTheme.notWhite.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
          widget.forChannel
              ? Column(children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        height: iconContainerSpace,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 40.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            widget.changeChannel.call(31);
                            setState(() {
                              widget.isDrink = false;
                              //info = !info;
                            });
                          },
                          icon: Icon(
                            Icons.fastfood,
                            size: iconSize * 1.5,
                            color: widget.isDrink
                                ? Colors.white.withOpacity(0.5)
                                : Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        height: iconContainerSpace,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.7),
                              blurRadius: 40.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            widget.changeChannel.call(32);
                            setState(() {
                              widget.isDrink = true;
                              //info = !info;
                            });
                          },
                          icon: Icon(
                            Icons.free_breakfast,
                            size: iconSize * 1.5,
                            color: widget.isDrink
                                ? Colors.white.withOpacity(0.9)
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ])
              : Container(),
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
          detailsInfo
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Colors.black.withOpacity(0.8)),
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
                            fontSize: 20,
                            fontFamily: "calibril"),
                        textAlign: TextAlign.center,
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
