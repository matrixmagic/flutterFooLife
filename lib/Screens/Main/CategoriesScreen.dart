import 'dart:convert';

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pedantic/pedantic.dart';

import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/CustomProductWidget.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';

class CategoriesScreen extends StatefulWidget {
  int restaurantid;
  int categoryId;

  CategoriesScreen({this.categoryId, this.restaurantid}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Function stopVideo;
  int lastShowIndex = 0;
  List<ProductDto> products;
  double _screenWidth = WidgetsBinding.instance.window.physicalSize.width;
  double _screenHeight = WidgetsBinding.instance.window.physicalSize.height;
  List<BetterPlayer> VideosPlayers;
  List<BetterPlayerController> VideoControllerCashed;

  List<BetterPlayerController> VideoControllerStream;
  List<FileInfo> filesInfo;

  DefaultCacheManager _cacheManager;
  bool isfirstTime = false;

  Future<void> getAllProduct() async {
    var prods = await RestaurantRepository()
        .getAllProductInCatgory(widget.categoryId, widget.restaurantid);

    prods.forEach((element) {
      if (element.file.extension == 'mp4') {
        BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.NETWORK,
          element.file.path,
          liveStream: true,
        );
        BetterPlayerController _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: false,
            looping: true,
            aspectRatio: _screenWidth / _screenHeight,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                liveText: "", showControls: false),
          ),
          betterPlayerDataSource: betterPlayerDataSource,
        );

        _betterPlayerController.setVolume(100);
        _betterPlayerController.pause();

        VideoControllerStream.add(_betterPlayerController);
      } else {
        VideoControllerStream.add(BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: false,
            looping: true,
            aspectRatio: _screenWidth / _screenHeight,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                liveText: "", showControls: false),
          ),
        ));
      }
    });
    setState(() {
      products = prods;
    });

    CacheAllInTerm();
  }

  void CacheAllInTerm() async {
    products.forEach((element) async {
      if (element.file.extension == 'mp4') {
        FileInfo fileInfo =
            await _cacheManager.getFileFromCache(element.file.path);
        if (fileInfo == null || fileInfo.file == null) {
          fileInfo = await _cacheManager.downloadFile(element.file.path);
        }
        print('[VideoControllerService]: Loading video from cache');

        BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.FILE,
          fileInfo.file.path,
          liveStream: true,
        );
        BetterPlayerController _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: false,
            looping: true,
            aspectRatio: _screenWidth / _screenHeight,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                liveText: "", showControls: false),
          ),
          betterPlayerDataSource: betterPlayerDataSource,
        );

        _betterPlayerController.setVolume(100);
        _betterPlayerController.pause();
        VideoControllerCashed.add(_betterPlayerController);

        filesInfo.add(fileInfo);
      } else {
        filesInfo.add(null);
        VideoControllerCashed.add(BetterPlayerController(
          BetterPlayerConfiguration(
            autoPlay: false,
            looping: true,
            aspectRatio: _screenWidth / _screenHeight,
            controlsConfiguration: BetterPlayerControlsConfiguration(
                liveText: "", showControls: false),
          ),
        ));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    VideoControllerStream = new List();
    VideoControllerCashed = new List();
    filesInfo = new List();
    _cacheManager = DefaultCacheManager();
    getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
        body: products != null
            ? Stack(
                children: <Widget>[
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      if (!isfirstTime && index == 0) {
                        if (VideoControllerCashed.length > index) {
                          if( VideoControllerCashed[index].isVideoInitialized()){
                          VideoControllerCashed[index].setVolume(100);
                          VideoControllerCashed[index].play();
                             print("oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
                          }
                          else{

                            print("dsffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
                          }
                        } else {
                          VideoControllerStream[index].setVolume(100);
                          VideoControllerStream[index].play();
                        }
                        isfirstTime = true;
                      }

                      return CustomProductWidget(
                        product: products[index],
                        betterPlayerController:
                            products[index].file.extension == 'mp4'
                                ? VideoControllerCashed.length > index
                                    ? VideoControllerCashed[index]
                                    : VideoControllerStream[index]
                                : null,
                        forChannel: false,
                      );
                    },
                    itemCount: products.length,
                    scrollDirection: Axis.vertical,
                    scale: 1.0,
                    onIndexChanged: (index) {
                      print(index.toString());
                      if (products[lastShowIndex].file.extension == 'mp4') {
                        VideoControllerCashed[lastShowIndex].setVolume(0);
                        VideoControllerCashed[lastShowIndex].pause();

                        VideoControllerStream[lastShowIndex].setVolume(0);
                        VideoControllerStream[lastShowIndex].pause();
                        VideoControllerStream[lastShowIndex].dispose();
                      
                        VideoControllerStream.removeAt(lastShowIndex);

                      }

                      if (products[index].file.extension == 'mp4') {
                        if (VideoControllerCashed.length > index) {
                          VideoControllerCashed[index].setVolume(100);
                          VideoControllerCashed[index].play();
                        } else
                          VideoControllerStream[index].setVolume(100);
                        VideoControllerStream[index].play();
                      }

                      for(int i=0; i<3;i++){
                          int j=(i-1)%VideoControllerCashed.length;
                        if (products[j].file.extension == 'mp4') {
                        if (VideoControllerCashed.length > j) {
                          if (!VideoControllerCashed[j].isVideoInitialized()) {

                            print('newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
                            BetterPlayerDataSource betterPlayerDataSource =
                                BetterPlayerDataSource(
                              BetterPlayerDataSourceType.FILE,
                              filesInfo[j].file.path,
                            );
                            VideoControllerCashed[j] =
                                BetterPlayerController(
                              BetterPlayerConfiguration(
                                autoPlay: false,
                                looping: true,
                                aspectRatio: _screenWidth / _screenHeight,
                                controlsConfiguration:
                                    BetterPlayerControlsConfiguration(
                                        liveText: "", showControls: false),
                              ),
                              betterPlayerDataSource: betterPlayerDataSource,
                            );

                            VideoControllerCashed[j].setVolume(100);
                            VideoControllerCashed[j].pause();
                          }
                        }
                      }





                      }

                      lastShowIndex = index;
                    },
                  ),
                  Positioned(
                      bottom: 0,
                      left: 5.0,
                      right: 5.0,
                      child: Container(
                        child: CustomButtomNavigatior(),
                      )),
                  FutureBuilder(
                      future: RestaurantRepository()
                          .getRestrantCategory(widget.restaurantid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Positioned(
                              bottom: 40,
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: MenuBar(
                                      items: snapshot.data,
                                      isProduct: true,
                                      lastCategoryId: widget.categoryId)));
                        } else
                          return Container();
                      }),
                ],
              )
            : Container());
  }

  _ParentFunction() async {
    await _showSelectionDialog(_context);
  }

  BuildContext _context;

  Future<void> _showSelectionDialog(BuildContext context) async {
    print('im clicked hiiiii');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Sign up"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/usersignup');
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Log in"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signin');
                  },
                )
              ],
            ),
          ));
        });
  }
}
