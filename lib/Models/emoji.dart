import 'package:flutter/material.dart';

class EmojiView extends StatefulWidget {
  
  final Function ontap;
  final double fontsize;
  final String value;
  final TextAlign align;
  const EmojiView(
      {Key key,
      this.ontap,
      this.fontsize,
      this.value,
      this.align})
      : super(key: key);
  @override
  _EmojiViewState createState() => _EmojiViewState();
}

class _EmojiViewState extends State<EmojiView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.value,
                textAlign: widget.align,
                style: TextStyle(
                  fontSize: widget.fontsize,
                ),
      ),
    );
  }
}
