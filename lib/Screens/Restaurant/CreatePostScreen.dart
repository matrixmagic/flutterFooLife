import 'dart:async';
import 'dart:io';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:foolife/Models/all_emojies.dart';
import 'package:foolife/Models/colors_picker.dart';
import 'package:foolife/Models/emoji.dart';
import 'package:foolife/Models/text.dart';
import 'package:foolife/Models/textview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:signature/signature.dart';
import '../../AppTheme.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

List multiwidget = [];
List fontsize = [];
Color currentcolors = Colors.white;
var slider = 0.0;
SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.green);
var howmuchwidgetis = 0;

class _CreatePostState extends State<CreatePost> {
  ScreenshotController screenshotController = ScreenshotController();
  bool timingVisibility;
  var openbottomsheet = false;
  final GlobalKey globalKey = new GlobalKey();
  final scaf = GlobalKey<ScaffoldState>();
  List<Offset> _points = <Offset>[];
  List<Offset> offsets = [];
  List type = [];
  List fontcolor = [];
  Map<String, bool> week;

  Timer timeprediction;
  TimeOfDay fromDate;
  TimeOfDay toDate;
  void timers() {
    Timer.periodic(Duration(milliseconds: 10), (tim) {
      setState(() {});
      timeprediction = tim;
    });
  }

  @override
  void dispose() {
    timeprediction.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    timers();
    timingVisibility = false;
    _controller.clear();
    type.clear();
    fontsize.clear();
    fontcolor.clear();
    offsets.clear();
    multiwidget.clear();
    howmuchwidgetis = 0;
    week = {
      "Mo.": false,
      "Tu.": false,
      "We.": false,
      "Wi.": false,
      "Th.": false,
      "Fi.": false,
      "Sa.": false,
    };
    // TODO: implement initState
    super.initState();
  }
void toggeltimingVisibility(){
  setState(() {
   timingVisibility ? timingVisibility=false: timingVisibility=true;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaf,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    //////// the body
                    Center(
                      child: Screenshot(
                        controller: screenshotController,
                        child: Container(
                          margin: EdgeInsets.all(0),
                          color: Colors.transparent,
                          width: double.infinity,
                          height: double.infinity,
                          child: RepaintBoundary(
                              key: globalKey,
                              child: Stack(
                                children: <Widget>[
                                  Stack(
                                    children:
                                        multiwidget.asMap().entries.map((f) {
                                      return type[f.key] == 1
                                          ? EmojiView(
                                              left: offsets[f.key].dx,
                                              top: offsets[f.key].dy,
                                              ontap: () {
                                                showDialog(
                                                    context: context,
                                                    child: AlertDialog(
                                                        content:
                                                            SingleChildScrollView(
                                                                child: Sliders(
                                                      size: f.key,
                                                      sizevalue: fontsize[f.key]
                                                          .toDouble(),
                                                    ))));
                                              },
                                              onpanupdate: (details) {
                                                setState(() {
                                                  offsets[f.key] = Offset(
                                                      offsets[f.key].dx +
                                                          details.delta.dx,
                                                      offsets[f.key].dy +
                                                          details.delta.dy);
                                                });
                                              },
                                              value: f.value.toString(),
                                              fontsize:
                                                  fontsize[f.key].toDouble(),
                                              align: TextAlign.center,
                                            )
                                          : type[f.key] == 2
                                              ? TextView(
                                                  left: offsets[f.key].dx,
                                                  top: offsets[f.key].dy,
                                                  value: f.value.toString(),
                                                  fontsize: fontsize[f.key]
                                                      .toDouble(),
                                                  color: fontcolor[f.key],
                                                  align: TextAlign.center,
                                                  ontap: () {
                                                    showDialog(
                                                        context: context,
                                                        child: AlertDialog(
                                                            content:
                                                                SingleChildScrollView(
                                                                    child:
                                                                        Sliders(
                                                          size: f.key,
                                                          sizevalue:
                                                              fontsize[f.key]
                                                                  .toDouble(),
                                                        ))));
                                                  },
                                                  onpanupdate: (details) {
                                                    setState(() {
                                                      offsets[f.key] = Offset(
                                                          offsets[f.key].dx +
                                                              details.delta.dx,
                                                          offsets[f.key].dy +
                                                              details.delta.dy);
                                                    });
                                                  },
                                                  onlongpress: () async {
                                                    final MapEntry newvalue =
                                                        await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TextEditor(f
                                                                        .value)));
                                                    if (newvalue.key
                                                        .toString()
                                                        .isEmpty) {
                                                      print("true");
                                                    } else {
                                                      multiwidget[f.key] =
                                                          newvalue.key;
                                                      fontcolor[f.key] =
                                                          newvalue.value;
                                                    }
                                                  },
                                                )
                                              : new Container();
                                    }).toList(),
                                  )
                                ],
                              )),
                        ),
                      ),
                    ),
                    openbottomsheet
                        ? new Container()
                        : Positioned(
                              bottom: 40,
                              left: 5.0,
                              right: 5.0,
                              child: Column(
                                children: <Widget>[
                                  Visibility(
                                    visible: timingVisibility,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: week.entries.map((day) {
                                            return checkbox(day.key, day.value);
                                          }).toList(),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text(
                                              "From:",
                                              style: TextStyle(
                                                  color: AppTheme.notWhite),
                                            ),
                                            FlatButton(
                                              child: Text(
                                                fromDate == null
                                                    ? "Click"
                                                    : fromDate.format(context),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              onPressed: () {
                                                showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                ).then(
                                                    (value) => fromDate = value);
                                              },
                                            ),
                                            Text(
                                              "To:",
                                              style: TextStyle(
                                                  color: AppTheme.notWhite),
                                            ),
                                            FlatButton(
                                              child: Text(
                                                toDate == null
                                                    ? "Click"
                                                    : toDate.format(context),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                              onPressed: () {
                                                showTimePicker(
                                                  initialTime: TimeOfDay.now(),
                                                  context: context,
                                                ).then((value) => toDate = value);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.text_fields,
                                            color: AppTheme.notWhite,
                                          ),
                                          onPressed: () async {
                                            final MapEntry value =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TextEditor("")));
                                            if (value.key.toString().isEmpty) {
                                              print("true");
                                            } else {
                                              type.add(2);
                                              fontsize.add(22);
                                              offsets.add(Offset.zero);
                                              multiwidget.add(value.key);
                                              fontcolor.add(value.value);
                                              howmuchwidgetis++;
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.layers_clear,
                                            color: AppTheme.notWhite,
                                            size: 35,
                                          ),
                                          onPressed: () {
                                            _controller.clear();
                                            type.clear();
                                            fontsize.clear();
                                            offsets.clear();
                                            multiwidget.clear();
                                            howmuchwidgetis = 0;
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.face,
                                            color: AppTheme.notWhite,
                                          ),
                                          onPressed: () {
                                            Future getemojis =
                                                showModalBottomSheet(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return Emojies();
                                                    });
                                            getemojis.then((value) {
                                              if (value != null) {
                                                type.add(1);
                                                fontsize.add(20);
                                                offsets.add(Offset.zero);
                                                multiwidget.add(value);
                                                howmuchwidgetis++;
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                            color: AppTheme.notWhite,
                                          ),
                                          onPressed: toggeltimingVisibility,
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.done,
                                            color: AppTheme.notWhite,
                                          ),
                                          onPressed: () {
                                            // File _imageFile;
                                            // _imageFile = null;
                                            // screenshotController
                                            //     .capture(
                                            //         delay: Duration(milliseconds: 500), pixelRatio: 1.5)
                                            //     .then((File image) async {
                                            //   //print("Capture Done");
                                            //   setState(() {
                                            //     _imageFile = image;
                                            //   });
                                            //   final paths = await getExternalStorageDirectory();
                                            //   image.copy(paths.path +
                                            //       '/' +
                                            //       DateTime.now().millisecondsSinceEpoch.toString() +
                                            //       '.png');
                                            //   Navigator.pop(context, image);
                                            // }).catchError((onError) {
                                            //   print(onError);
                                            // });
                                          },
                                        ),
                                      ),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.visibility,
                                            color: AppTheme.notWhite,
                                          ),
                                          onPressed: toggeltimingVisibility,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            
                          )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: AppTheme.notWhite),
        ),
        Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: boolValue,
              focusColor: AppTheme.notWhite,
              onChanged: (bool value) {
                setState(() {
                  week[title] = value;
                });
              },
            ))
      ],
    );
  }
}

class Sliders extends StatefulWidget {
  final int size;
  final sizevalue;
  const Sliders({Key key, this.size, this.sizevalue}) : super(key: key);
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  @override
  void initState() {
    slider = widget.sizevalue;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: new Text("Size Slider"),
        ),
        Divider(
          height: 1,
        ),
        new Slider(
            value: slider,
            min: 0.0,
            max: 100.0,
            onChangeEnd: (v) {
              setState(() {
                fontsize[widget.size] = v.toInt();
              });
            },
            onChanged: (v) {
              setState(() {
                slider = v;
                print(v.toInt());
                fontsize[widget.size] = v.toInt();
              });
            }),
      ],
    ));
  }
}

class ColorPiskersSlider extends StatefulWidget {
  @override
  _ColorPiskersSliderState createState() => _ColorPiskersSliderState();
}

class _ColorPiskersSliderState extends State<ColorPiskersSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: 260,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Text("Slider Filter Color"),
          ),
          Divider(
            height: 1,
          ),
          SizedBox(height: 20),
          new Text("Slider Color"),
          SizedBox(height: 10),
          BarColorPicker(
              width: 300,
              thumbColor: Colors.white,
              cornerRadius: 10,
              pickMode: PickMode.Color,
              colorListener: (int value) {
                setState(() {
                  //  currentColor = Color(value);
                });
              }),
          SizedBox(height: 20),
          new Text("Slider Opicity"),
          SizedBox(height: 10),
          Slider(value: 0.1, min: 0.0, max: 1.0, onChanged: (v) {})
        ],
      ),
    );
  }
}
