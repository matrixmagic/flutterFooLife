import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:foolife/Bloc/Restaurant/ChangeBackgroundBloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_trimmer/storage_dir.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_trimmer/trim_editor.dart';
import 'package:video_trimmer/video_viewer.dart';

class TrimmerView extends StatefulWidget {
  final Trimmer _trimmer;
  final AddProductBloc addProductBloc;
  ChangeBackgroundBloc changeBackgroundBloc;
  File video;
  TrimmerView(this._trimmer, {this.addProductBloc, this.video,this.changeBackgroundBloc});
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;



  bool _isPlaying = false;
  bool _progressVisibility = false;

  
String  _miliSecoundToString(double time){
  double  toSecond=time/1000;
  int sec = (toSecond%60).toInt();
  double  toMinute=(toSecond-sec)/60;
  int min =(toMinute%60).toInt();
  double  toHour=(toMinute-min)/60;
  int hour =(toHour%60).toInt();
  String sec_str=sec>=10?sec.toString():"0"+sec.toString();
  String min_str=min>=10?min.toString():"0"+min.toString();
  String hour_str=hour>=10?hour.toString():"0"+hour.toString();

  return hour_str+":"+min_str+":"+sec_str;


}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Visibility(
                  visible: _progressVisibility,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
                RaisedButton(
                  onPressed: _progressVisibility
                      ? null
                      : () async {
                          Directory appDocumentDir =
                              await getExternalStorageDirectory();

                          String rawDocumentPath = appDocumentDir.path;
                          print(rawDocumentPath);

                          var _random = new Random();
                          var _rand = _random.nextInt(9999999) + 1;
                          String outputPath =
                              rawDocumentPath + "/" + _rand.toString() + ".mp4";
                          final FlutterFFmpeg _flutterFFmpeg =
                              new FlutterFFmpeg();


                              _endValue= _endValue<= _startValue ? _startValue+16*1000:_endValue;
              
                       
                          _flutterFFmpeg
                              .execute("-i " +
                                  widget.video.path +
                                  " -ss "+_miliSecoundToString(_startValue) +" -t "+ ((_endValue - _startValue) >= (15*1000) ?"00:00:15":_miliSecoundToString(_endValue - _startValue))+ " -c:v copy -c:a copy  " +
                                  outputPath)
                              .then((rc) {
                            if (rc == 0) {
                              File video = new File(outputPath);

                              final snackBar = SnackBar(
                                  content: Text('Video Saved successfully'));
                                  if(widget.addProductBloc != null)
                              widget.addProductBloc.changeFile(video);
                              if(widget.changeBackgroundBloc != null)
                              widget.changeBackgroundBloc.changeFile(video);
                              Scaffold.of(context).showSnackBar(snackBar);
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                                Navigator.of(context).pop();
                              });
                            } else {
                              final snackBar =
                                  SnackBar(content: Text('Video error'));

                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          });
                        },
                  child: Text("Trim"),
                ),
                Expanded(
                  child: VideoViewer(),
                ),
                Center(
                  child: TrimEditor(
                    viewerHeight: 50.0,
                    viewerWidth: MediaQuery.of(context).size.width,
                    onChangeStart: (value) {
                      _startValue = value;
                       
                    },
                    onChangeEnd: (value) {
                      _endValue = value;
                    },
                    onChangePlaybackState: (value) {
                      setState(() {
                        _isPlaying = value;
                      });
                    },
                  ),
                ),
                FlatButton(
                  child: _isPlaying
                      ? Icon(
                          Icons.pause,
                          size: 80.0,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.play_arrow,
                          size: 80.0,
                          color: Colors.white,
                        ),
                  onPressed: () async {
                    bool playbackState =
                        await widget._trimmer.videPlaybackControl(
                      startValue: _startValue,
                      endValue: _endValue,
                    );
                    setState(() {
                      _isPlaying = playbackState;
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
