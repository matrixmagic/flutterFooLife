import 'package:flutter/material.dart';
class TextView extends StatefulWidget {
  final Function onDoubleTap;
  final Function onlongpress;
  final double fontsize;
  final String value;
  final TextAlign align;
  final Color color; 
  const TextView(
      {Key key,
      this.onlongpress,
      this.onDoubleTap,
      this.fontsize,
      this.value,
      this.align,
      this.color})
      : super(key: key);
  @override
  _TextViewState createState() => _TextViewState();
}

class _TextViewState extends State<TextView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: widget.onlongpress,
          onDoubleTap: widget.onDoubleTap,
          child: Text(widget.value,
              textAlign: widget.align,
              style: TextStyle(
                fontSize: widget.fontsize,
                color: widget.color
              )),
    );
  }
}
