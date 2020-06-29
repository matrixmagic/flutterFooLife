import 'package:flutter/cupertino.dart';
import 'package:flutter_instagram_stories/flutter_instagram_stories.dart';
import 'package:foolife/AppTheme.dart';
import 'package:video_player/video_player.dart';

class Story extends StatefulWidget {
  @override
  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {

  StoryController controller;
  @override
  Widget build(BuildContext context) {

    List<StoryItem> storyItems = [
    StoryItem.text("helllo",AppTheme.primaryColor),
    StoryItem.pageImage(AssetImage("assets/images/Restaurant1.jpg")),

  ]; 
    return StoryView(
    storyItems,
    controller: controller, // pass controller here too
    repeat: false, // should the stories be slid forever
    onStoryShow: (s) {
      
    },
    onComplete: () {Navigator.pop(context);},
     // To disable vertical swipe gestures, ignore this parameter.
      // Preferrably for inline story view.
  );
}
  }