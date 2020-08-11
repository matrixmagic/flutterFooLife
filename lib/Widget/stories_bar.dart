import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Screens/Main/story.dart';

class storiesBar extends StatefulWidget {
  List<String> images;
  Map<int,bool> appear;
  storiesBar({this.images,this.appear});
  @override
  _storiesBarState createState() => _storiesBarState();
}

class _storiesBarState extends State<storiesBar> {

  @override
  void initState() {
    // TODO: implement initState
    print("hiii");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        itemCount: widget.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          index = index % (widget.images.length + 1);
          final item = widget.images[index];
          return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Story(id: 1,length:widget.images.length)),
              ),
              child: Dismissible(
                key: Key(item),
                direction: DismissDirection.up,
                // Provide a function that tells the app
                // what to do after an item has been swiped away.
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    widget.images.removeAt(index);
                  });
                  // Then show a snackbar.
                },
                // Show a red background as the item is swiped away.
                background: Container(
                    width: 49.0,
                    height: 49.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color:Colors.black38),
                  child: Center(child: Text("geloscht",style: TextStyle(color:Colors.white,fontSize: 12),)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(49.0),

                    child: Container(
                        width: 49.0,
                        height: 49.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            image: DecorationImage(
                                image: AssetImage(
                                  widget.images[index],

                                ),
                                fit: BoxFit.fill
                            ))),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

/*
appear ? Center(
            child: Draggable(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(49.0),

                child: Container(
                    width: 49.0,
                    height: 49.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/images/backgound.jpg",

                            ),
                            fit: BoxFit.fill
                        ))),
              ),
              data: 1,
              axis: Axis.vertical,
              feedback: Container(),
              childWhenDragging: ClipRRect(
                borderRadius: BorderRadius.circular(49.0),

                child: Container(
                    width: 49.0,
                    height: 49.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color:Colors.black12)),
              ),
              onDragCompleted: (){
                setState(() {
                  appear = false;
                });
              },
            ),
          ):Container(),

          DragTarget(
            builder: (BuildContext context, List<int> candidateData,
                List<dynamic> rejectedData) {
              print("candidateData = " +
                  candidateData.toString() +
                  " , rejectedData = " +
                  rejectedData.toString());
              return Icon(Icons.delete_forever,color:Colors.red);
            },
            onWillAccept: (data) {
              print("onWillAccept");
              return data == 1 || data == -1; // accept when data = 1 only.
            },
            onAccept: (data) {
              print("onAccept");
              setState(() {
                appear = false;
              });

            },
            onLeave: (data) {
              print("onLeave");
            },
          )
 */
