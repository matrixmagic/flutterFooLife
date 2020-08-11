import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  TextEditingController editingController = TextEditingController();

  //create data structure
  final duplicateItems  = ["Cafe Extrablatt Bremen","Cafe Extrablatt Mainz Schillerplatz","Cafe Extrablatt Mainz am Markt","Cafe Extrablatt Hamburg"];

  var items = List<String>();

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:17,vertical: 17),
                child: Container(
                  height: 50,
                  padding:  EdgeInsets.symmetric(horizontal:5),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.all(Radius.circular(25)),
                    color:Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        offset: Offset(0.0, 3.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 15 ,
                      color: Colors.black,
                    ),
                    controller: editingController,
                    onChanged: (value) async {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search,color: Colors.black,),
                      //Image.asset("asset/user.png"),
                      hintText:"Search",
                      hintStyle: TextStyle(
                        fontSize: 15 ,
                        color: Colors.black,
                      ),

                    ),
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Dismissible(
                      key: Key(item),
                      // Provide a function that tells the app
                      // what to do after an item has been swiped away.
                      onDismissed: (direction) {
                        // Remove the item from the data source.
                        setState(() {
                          items.removeAt(index);
                        });
                        // Then show a snackbar.
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("$item dismissed")));
                      },
                      // Show a red background as the item is swiped away.
                      background: Container(
                        color: Color.fromRGBO(47, 52, 63, 0.5),
                        child: Center(child: Text("geloscht",style: TextStyle(color:Colors.white,fontSize: 15),)),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(5),
                        title: Text('${items[index]}'),
                        leading: new Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new AssetImage(
                                        "assets/images/kfc.jpg")
                                )
                            )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
