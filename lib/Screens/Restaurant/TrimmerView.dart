
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:foolife/Bloc/Product/add/AddProductBloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_trimmer/storage_dir.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:video_trimmer/trim_editor.dart';
import 'package:video_trimmer/video_viewer.dart';

class TrimmerView extends StatefulWidget {
  final Trimmer _trimmer;
  final AddProductBloc addProductBloc;
  TrimmerView(this._trimmer,this.addProductBloc);
  @override
  _TrimmerViewState createState() => _TrimmerViewState();
}

class _TrimmerViewState extends State<TrimmerView> {
  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String _value;


    await widget._trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue,storageDir: StorageDir.externalStorageDirectory )
        .then((value) {
      setState(() {
        _progressVisibility = false;
        _value = value;
      });
    });

    return _value;
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
                          _saveVideo().then((outputPath) {
                            print('OUTPUT PATH: $outputPath');
                            final snackBar = SnackBar(content: Text('Video Saved successfully'));
                                  File video=new File(outputPath);
                            widget.addProductBloc.changeFile(video);
                            Scaffold.of(context).showSnackBar(snackBar);
                             SchedulerBinding.instance.addPostFrameCallback((_) {
                                     // Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
                                      Navigator.of(context).pop();
                        });
                         
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
                      // _endValue = _endValue -value >=15*1000?value+15*1000:_endValue;
                      // print("defff is "+ (_endValue -value ).toString() );
                      _startValue = value;
                    },
                    onChangeEnd: (value) {
                      // _startValue = value-_startValue >=15*1000?value-15*1000:_startValue;
                      // print("defff is "+ (value-_startValue  ).toString() );
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