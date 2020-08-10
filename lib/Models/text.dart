import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:signature/signature.dart';

import '../AppTheme.dart';

class TextEditor extends StatefulWidget {
  @override
  _TextEditorState createState() => _TextEditorState();
  final String prevText;
  TextEditor(this.prevText);
}

SignatureController _controller =
    SignatureController(penStrokeWidth: 5, penColor: Colors.green);

class _TextEditorState extends State<TextEditor> {
  
  TextEditingController name = TextEditingController();
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
    var points = _controller.points;
    _controller =
        SignatureController(penStrokeWidth: 5, penColor: color, points: points);
  }
@override
void initState() {
    // TODO: implement initState
    super.initState();
    name.text= widget.prevText;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        actions: <Widget>[
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignLeft), onPressed: () {}),
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignCenter), onPressed: () {}),
          new IconButton(
              icon: Icon(FontAwesomeIcons.alignRight), onPressed: () {}),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Insert your message",
                  hintStyle: TextStyle(color: Colors.white),
                  alignLabelWithHint: true,
                ),
                scrollPadding: EdgeInsets.all(20.0),
                keyboardType: TextInputType.multiline,
                maxLines: 99999,
                style: TextStyle(
                  color: Colors.white,
                ),
                autofocus: true,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: IconButton(
              icon: Icon(
                Icons.brush,
                color: AppTheme.notWhite,
              ),
              onPressed: () {
                // raise the [showDialog] widget
                showDialog(
                    context: context,
                    child: AlertDialog(
                      title: const Text('Pick a color!'),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          showLabel: true,
                          pickerAreaHeightPercent: 0.8,
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Got it'),
                          onPressed: () {
                            setState(() => currentColor = pickerColor);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ));
              },
            ),
          ),
          FlatButton(
                onPressed: () {
                  Navigator.pop(context, MapEntry(name.text, currentColor));
                },
                color: Colors.black,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: new Text(
                  "Add Text",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white),
                )),
         
        ],
      ),
    );
  }
}
