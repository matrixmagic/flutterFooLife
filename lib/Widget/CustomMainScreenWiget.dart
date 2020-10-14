import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Screens/Restaurant/CreatePostScreen.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/my_flutter_app_icons.dart';
import 'package:pedantic/pedantic.dart';

import '../AppTheme.dart';
import 'my_flutter_app_icons3.dart';
import 'qrcode1.dart';

class CustomMainScreenWiget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CustomMainScreenWiget();
  CustomMainScreenWiget({this.restauranDto});

  RestaurantDto restauranDto;
 
}

class _CustomMainScreenWiget extends State<CustomMainScreenWiget> {
  bool mainScreenWidgetVisibility = true;
  bool postScreenWidgetVisibility = false;
  DefaultCacheManager _cacheManager;
  bool info = false;
  BetterPlayerController _betterPlayerController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();

    _cacheManager = DefaultCacheManager();
    if (widget.restauranDto.file.extension == "mp4") {
      print(widget.restauranDto.file.path);

      getVideoController();
    }
  }

  void getVideoController() async {
    double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
    double _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
    var x = await getControllerForVideo(
        widget.restauranDto.file.path, _screenWidth, _screenHeight);
    setState(() {
      _betterPlayerController = x;
    });
  }

  void openCreatePostScreen() {
    setState(() {
      mainScreenWidgetVisibility = false;
      postScreenWidgetVisibility = true;
    });
  }

  void closeCreatePostScreen() {
    setState(() {
      mainScreenWidgetVisibility = true;
      postScreenWidgetVisibility = false;
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
    return Container(height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.grey,
          body: Stack(children: <Widget>[
            Container(
              child: widget.restauranDto.file.extension != "mp4"
                  ? CachedNetworkImage(
                      imageUrl: (widget.restauranDto == null ||
                              widget.restauranDto.file == null ||
                              widget.restauranDto.file.path == null)
                          ? "https://www.insperry.com/Insperry/public/uploads/files/store/08_03_2020_23_51_78Restaurant1.jpg"
                          : widget.restauranDto.file.path,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
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
            widget.restauranDto.post != null
                ? Container(
                    child: Image(
                      image: NetworkImage(widget.restauranDto.post.file.path),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(),
            Visibility(
              visible: postScreenWidgetVisibility,
              child: Container(
                  child: CreatePost(
                close_it: closeCreatePostScreen,
              )),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            blurRadius: 40.0,
                            spreadRadius: 1.0,
                          ),
                        ]),
                        child: Text(
                          widget.restauranDto.name,
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 15,
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: mainScreenWidgetVisibility,
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height / 7),
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
                                size: MediaQuery.of(context).size.height / 21,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Text(
                            '22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
                          )
                        ],
                      ),
                    ),
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
                              icon: Icon(
                                Icons.star,
                                size: MediaQuery.of(context).size.height / 21,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          Text('22',
                              style: TextStyle(
                                color: Colors.white.withOpacity(1),
                              ))
                        ],
                      ),
                    ),
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
                          child: IconButton(
                            icon: Icon(
                              Icons.person,
                              size: MediaQuery.of(context).size.height / 21,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text('22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)))
                      ],
                    ),
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
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              size: MediaQuery.of(context).size.height / 21,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text('22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)))
                      ],
                    ),
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
                          child: IconButton(
                            icon: Icon(
                              MyFlutterApp.kellner_option,
                              size: MediaQuery.of(context).size.height / 21,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text('22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)))
                      ],
                    ),
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
                          child: IconButton(
                            icon: Icon(
                              Icons.insert_comment,
                              size: MediaQuery.of(context).size.height / 21,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                        Text('22',
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.8)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                right: 5.0,
                bottom: 90,
                
                child: mainScreenWidgetVisibility
                    ? Container(
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
                              icon: Icon(
                                qrcode1.ddd__1_,
                                color: AppTheme.notWhite.withOpacity(0.7),
                              ),
                              onPressed: openCreatePostScreen,
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
                            child: IconButton(
                              icon: Icon(
                                StoryICons.burning_meteor,
                                color: AppTheme.notWhite.withOpacity(0.7),
                              ),
                              onPressed: openCreatePostScreen,
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
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: AppTheme.notWhite.withOpacity(0.7),
                              ),
                              onPressed: openCreatePostScreen,
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
                            child: IconButton(
                                icon: Icon(
                                  Icons.info,
                                  color: AppTheme.notWhite.withOpacity(0.7),
                                ),
                                onPressed: () {
                                  setState(() {
                                    info = !info;
                                  });
                                }),
                          )
                        ],
                      ))
                    : Container(
                        child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: AppTheme.notWhite,
                          size: 27,
                        ),
                        onPressed: closeCreatePostScreen,
                      ))),
            Visibility(
              visible: mainScreenWidgetVisibility,
              child: widget.restauranDto.categories != null &&widget.restauranDto.categories.length > 0
                  ? Positioned(
                      bottom: 40,
                      child: Container(
                          height: 40,
                          width: 500,
                          child: MenuBar(items:  widget.restauranDto.categories)))
                  : Container(),
            ),
            info
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 90),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(colors: [
                          Colors.green.withOpacity(0.4),
                          Colors.pinkAccent.withOpacity(0.4)
                        ]),
                      ),
                      child: Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 1200,
                          width: 400,
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  widget.restauranDto.name,
                                  textAlign: TextAlign.start,
                                  style: AppTheme.insperryTheme,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "United Kingdom",
                                  textAlign: TextAlign.start,
                                  style: AppTheme.insperryTheme,
                                ),
                              ),
                              Text(
                                widget.restauranDto.city +
                                    ", " +
                                    widget.restauranDto.street,
                                style: AppTheme.insperryTheme,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "telephon:",
                                      textAlign: TextAlign.start,
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Text(
                                    widget.restauranDto.user.phoneNumber,
                                    style: AppTheme.insperryTheme,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "fax:",
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Text(
                                    widget.restauranDto.fax,
                                    style: AppTheme.insperryTheme,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 50,
                                  ),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "Email:",
                                      textAlign: TextAlign.start,
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      widget.restauranDto.user.email,
                                      style: AppTheme.insperryTheme,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                width: 120,
                                child: Text(
                                  "openingtime:",
                                  style: AppTheme.insperryTheme,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 50),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "opentime:",
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Text(
                                    widget.restauranDto.openTime,
                                    style: AppTheme.insperryTheme,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 50),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "closetime:",
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Text(
                                    widget.restauranDto.closeTime,
                                    style: AppTheme.insperryTheme,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 50),
                                  Container(
                                    width: 120,
                                    child: Text(
                                      "Payment Method:",
                                      style: AppTheme.insperryTheme,
                                    ),
                                  ),
                                  Container(
                                      width: 70,
                                      child: Wrap(
                                        children: getPaymentMethod(),
                                      ))
                                ],
                              ),
                              Container(
                                width: 200,
                                child: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child: widget.restauranDto.services
                                                    .gamepad ==
                                                1
                                            ? Icon(
                                                FontAwesomeIcons.gamepad,
                                                color: AppTheme.primaryColor,
                                                size: 34,
                                              )
                                            : Container()),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child: widget.restauranDto.services
                                                    .accessible ==
                                                1
                                            ? Icon(
                                                Icons.accessible,
                                                color: AppTheme.primaryColor,
                                                size: 34,
                                              )
                                            : Container()),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child: widget.restauranDto.services
                                                    .childfriendly ==
                                                1
                                            ? Icon(
                                                Icons.child_friendly,
                                                color: AppTheme.primaryColor,
                                                size: 34,
                                              )
                                            : Container()),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child:
                                            widget.restauranDto.services.wifi == 1
                                                ? Icon(
                                                    Icons.wifi,
                                                    color: AppTheme.primaryColor,
                                                    size: 34,
                                                  )
                                                : Container()),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child:
                                            widget.restauranDto.services.power ==
                                                    1
                                                ? Icon(
                                                    Icons.power,
                                                    color: AppTheme.primaryColor,
                                                    size: 34,
                                                  )
                                                : Container()),
                                    Container(
                                        padding: EdgeInsets.all(7),
                                        child:
                                            widget.restauranDto.services.pets == 1
                                                ? Icon(
                                                    Icons.pets,
                                                    color: AppTheme.primaryColor,
                                                    size: 34,
                                                  )
                                                : Container()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container()
          ]),
        ),
      ),
    );
  }

  List<Widget> getPaymentMethod() {
    bool isfirst = true;
    return widget.restauranDto.paymentsMethod.map((e) {
      print(e.name);
      var text = Text(
        e.name,
        style: AppTheme.insperryTheme,
      );
      isfirst = false;
      return text;
    }).toList();
  }
}
