import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:foolife/AppTheme.dart';


class Story extends StatefulWidget {
  int id;
  int length;
  Story({this.id,this.length});
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  StoryController controller;
  @override
  Widget build(BuildContext context) {

    List<StoryItem> storyItems = [
      StoryItem.pageImage(AssetImage("assets/images/Restaurant2.jpg"),),
    ];
    return Stack(
      children: <Widget>[
        StoryView(
        storyItems,
        controller: controller, // pass controller here too
        repeat: false, // should the stories be slid forever
        onStoryShow: (s) {
        },
        onComplete: () {
          if(widget.id <widget.length){
            int nextStory = widget.id +1;
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Story(id: nextStory,length: widget.length,)),
            );
          }else{
            Navigator.pop(context);
          }
          },

         // To disable vertical swipe gestures, ignore this parameter.
          // Preferrably for inline story view.
  ),
        Positioned(bottom: 12,right: 25,child: Column(
          children: <Widget>[
            Icon(Icons.remove_red_eye, color: AppTheme.notWhite),
            Text("150",style: TextStyle(color: AppTheme.notWhite,fontSize: 15),)
          ],
        ) ),
       Positioned(bottom: 0,right: 25,child: Container(color: Colors.black, height: 16,width: 50,) )

      ],
    );
}
  }