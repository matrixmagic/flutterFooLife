import 'package:flutter/material.dart';
class TextView extends StatefulWidget {
  final double left;
  final double top;
  final Function ontap;
  final Function onlongpress;
  final Function(DragUpdateDetails) onpanupdate;
  final double fontsize;
  final String value;
  final TextAlign align;
  final Color color; 
  const TextView(
      {Key key,
      this.onlongpress,
      this.left,
      this.top,
      this.ontap,
      this.onpanupdate,
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
    return Positioned(
      left: widget.left+150,
      top: widget.top+250,
    
      child: GestureDetector(
        onLongPress: widget.onlongpress,
          onTap: widget.ontap,
          onPanUpdate: widget.onpanupdate,
          child: Text(widget.value,
              textAlign: widget.align,
              style: TextStyle(
                fontSize: widget.fontsize,
                color: widget.color
              ))),
    );
  }
}
