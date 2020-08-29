import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:foolife/Screens/Restaurant/TrimmerView.dart';
import 'package:foolife/Screens/Restaurant/VedioProduct.dart';
import 'package:foolife/Screens/Restaurant/addProductDetails.dart';
import 'package:foolife/Screens/Welcome/UserSignup.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:video_trimmer/video_trimmer.dart';

class AddProduct extends StatelessWidget {
  int categoryId;
  Function updateExplorer;

  AddProduct({this.categoryId, this.updateExplorer});
  AddProductBloc addProductBloc = new AddProductBloc();
  final Trimmer _trimmer = Trimmer();
  @override
  Widget build(BuildContext context) {
    addProductBloc.changeFood(true);
    addProductBloc.changeDrinks(false);
    addProductBloc.changeOthers(false);
    addProductBloc.changeCategoryId(categoryId);
    addProductBloc.chageDetails(" ");
    addProductBloc.changeProductName(" ");

    return Scaffold(
      /* resizeToAvoidBottomPadding: false,*/
      body: Stack(
        children: <Widget>[
          StreamBuilder<Object>(
              stream: addProductBloc.fileStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  File file = snapshot.data as File;
                  print("saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                  print(file.path);

                  String ext = file.path.substring(file.path.lastIndexOf("."));
                  print(ext);
                  if (ext != ".mp4") {
                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(snapshot.data),
                            fit: BoxFit.fitHeight,
                          ),
                        ));
                  } else {
                    return VideoProductView(file);
                  }
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/backgound.jpg",
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  );
                }
              }),
          //        Padding(
          //         padding : EdgeInsets.fromLTRB(10.0, 30, 30, 24),
          // child: TextField(

          //         autocorrect: true,
          //         decoration: InputDecoration(
          //           icon: Icon(Icons.verified_user,
          //               color: true
          //                   ? AppTheme.redText
          //                   : AppTheme.primaryColor),

          //           labelText: 'Email',
          //           hintText: 'Email adress',
          //           hintStyle: TextStyle(color: Colors.grey),
          //           filled: true,
          //           fillColor: Colors.white70,
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(12.0)),
          //             borderSide:
          //                 BorderSide(color: AppTheme.primaryColor, width: 2),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //             borderSide: BorderSide(
          //               color: AppTheme.primaryColor,
          //             ),
          //           ),
          //         ),
          //       )

          //        ),

          Positioned(
              child: Padding(
            padding: EdgeInsets.fromLTRB(200, 20, 0, 0),
            child: StreamBuilder(
                stream: addProductBloc.productNameStream,
                builder: (context, snapshot) {
                  return TextField(
                      style: TextStyle(color: Colors.white),
                      onChanged: addProductBloc.changeProductName,
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 16.0),
                        labelText: 'add a name of product',

                        //hintStyle: TextStyle(color: Colors.white),

                        filled: true,
                      ));
                }),
          )),
          StreamBuilder<Object>(
              stream: addProductBloc.fileStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Center(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Great!!! you uploaded your Product",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.autorenew,
                            size: 40,
                            color: AppTheme.notWhite,
                          ),
                          onPressed: () {
                            _settingModalBottomSheet(context, addProductBloc);
                          },
                        )
                      ],
                    ),
                  ));
                else {
                  return Center(
                      child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "add photo or video of your product",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 40,
                            color: AppTheme.notWhite,
                          ),
                          onPressed: () {
                            _settingModalBottomSheet(context, addProductBloc);
                          },
                        )
                      ],
                    ),
                  ));
                }
              }),
          StreamBuilder(
            stream: addProductBloc.submitRegisterStream,
            builder: (context, snapshot2) {
              print(snapshot2);
              if (snapshot2.hasData) {
                print(snapshot2);
                if (snapshot2.data == true) {
                  print("Navigator goo go");
                  updateExplorer.call();
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                } else if (snapshot2.data == false) {
                  Navigator.of(context).pop();
                  print("submit error");
                  return Text("eeeeee", style: AppTheme.error);
                }
                // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();

              }

              return Container();
            },
          ),

          Positioned(
              right: 20,
              bottom: 40,
              child: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.info,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => addProductDetails(
                                addProductBloc: addProductBloc)),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.check_circle,
                      size: 30,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      print("addd product");
                      Dialogs.showLoadingDialog(context);
                      addProductBloc.addRegister(true);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 30,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )),
          Positioned(
              bottom: 40,
              left: 10,
              child: Container(
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    StreamBuilder<Object>(
                        stream: addProductBloc.foodStream,
                        builder: (context, snapshot) {
                          return IconButton(
                              onPressed: () {
                                addProductBloc.changeFood(true);
                                addProductBloc.changeDrinks(false);
                                addProductBloc.changeOthers(false);
                              },
                              icon: Icon(Icons.fastfood,
                                  size: 40,
                                  color: snapshot.hasData && snapshot.data
                                      ? Colors.white
                                      : Colors.grey.withOpacity(0.8)));
                        }),
                    StreamBuilder<Object>(
                        stream: addProductBloc.drinksStream,
                        builder: (context, snapshot) {
                          return IconButton(
                              onPressed: () {
                                addProductBloc.changeFood(false);
                                addProductBloc.changeDrinks(true);
                                addProductBloc.changeOthers(false);
                              },
                              icon: Icon(Icons.free_breakfast,
                                  size: 40,
                                  color: snapshot.hasData && snapshot.data
                                      ? Colors.white
                                      : Colors.grey.withOpacity(0.8)));
                        }),
                    StreamBuilder<Object>(
                        stream: addProductBloc.othersStream,
                        builder: (context, snapshot) {
                          return IconButton(
                              onPressed: () {
                                addProductBloc.changeFood(false);
                                addProductBloc.changeDrinks(false);
                                addProductBloc.changeOthers(true);
                              },
                              icon: Icon(Icons.cached,
                                  size: 40,
                                  color: snapshot.hasData && snapshot.data
                                      ? Colors.white
                                      : Colors.grey.withOpacity(0.8)));
                        }),
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void _settingModalBottomSheet(context, AddProductBloc addProductBloc) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.image),
                    title: new Text('Photo'),
                    onTap: () async {
                      var picture = await MultiMediaPicker.pickImages(
                          source: ImageSource.gallery);
                      if (picture != null && picture.length > 0) {
                        Directory appDocumentDir =
                            await getExternalStorageDirectory();

                        String rawDocumentPath = appDocumentDir.path;
                        print(rawDocumentPath);

                        var _random = new Random();
                        var _rand = _random.nextInt(9999999) + 1;
                        String outputPath = rawDocumentPath +
                            "/" +
                            _rand.toString() +
                            "." +
                            picture[0]
                                .path
                                .substring(picture[0].path.length - 3);
                        print("fileeeeeeeeeeeeeeee:" + outputPath);
                        addProductBloc.changeFile(await testCompressAndGetFile(
                            picture[0], outputPath));
                      }

                      Navigator.of(bc).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Video'),
                  onTap: () async {
                    var video = await MultiMediaPicker.pickVideo(
                        source: ImageSource.gallery);

                    if (video != null) {
                      var videoo = await _trimmer.loadVideo(videoFile: video);

                      Navigator.of(bc)
                          .push(MaterialPageRoute(builder: (context) {
                        return TrimmerView(_trimmer,
                            addProductBloc: addProductBloc, video: video);
                      }));
                      //    addProductBloc.changeFile(video);
                      print(video.path);
                      //   Navigator.of(bc).pop();
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 70,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }
}
