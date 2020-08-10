import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/ProductExtraDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/MenuBar.dart';

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
  VideoPlayerController _controller;
  bool boolInfo = false;

  @override
  void initState() {
    super.initState();
    if (widget.extention == "mp4") {
      print(widget.backgroundImage);
      _controller = VideoPlayerController.network(widget.backgroundImage)
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
                : Center(
                    child: _controller != null
                        ? VideoPlayer(_controller)
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
          Positioned(
              left: 20,
              top: 10,
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
                        Text(
                          widget.product.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: "SpecialElite"),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                                (widget.product.price.toString() +
                                    "\$".toString()),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "SpecialElite")),
                            IconButton(
                                onPressed: () {
                                  print('im pressed');
                                  setState(() {
                                    boolInfo = !boolInfo;
                                  });
                                },
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 24,
                                )),
                          ],
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
                        '22',
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
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
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
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
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
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
                      Text('22',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          boolInfo != false
              ? Positioned(
                  top: 90,
                  right: 5,
                  child: CustomPaint(
                    painter: BorderPainter(),
                    child: ClipPath(
                        clipper: LinePathClass(),
                        child: Container(
                          width: 210,
                          padding: EdgeInsets.only(top: 25, left: 10, right: 4),
                          // margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppTheme.notWhite),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0))),

                          child: Column(
                            children: <Widget>[
                              widget.product.content != null
                                  ? Row(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            widget.product.content,
                                            style: TextStyle(
                                                color: AppTheme.notWhite,
                                                fontSize: 15,
                                                fontFamily: "SpecialElite"),
                                            textAlign: TextAlign.center,
                                          ),
                                          width: 120,
                                        ),
                                        widget.product.price != null
                                            ? Text(
                                                widget.product.price.toString(),
                                                style: TextStyle(
                                                    color: AppTheme.notWhite,
                                                    fontFamily: "SpecialElite",
                                                    fontSize: 15))
                                            : SizedBox()
                                      ],
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 5,
                              ),
                              widget.product.productExtra.length > 0
                                  ? Container(
                                      color: Colors.white,
                                      height: 1,
                                    )
                                  : SizedBox(),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: getExtraProduct(
                                    widget.product.productExtra),
                              ),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        )),
                  ))
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
                    fontSize: 15,
                    fontFamily: "SpecialElite")),
            SizedBox(
              width: 5,
            ),
            e.price != null
                ? Text(e.price,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
