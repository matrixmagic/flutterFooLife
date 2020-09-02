import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foolife/Widget/my_flutter_app_icons2.dart';
import 'package:foolife/Bloc/provider.dart';
import 'package:foolife/Bloc/searsch/SearchBloc.dart';

import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';

class SearchScreen extends StatelessWidget {
  @override
  void initState() {
    // TODO: implement initState

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent ,statusBarBrightness:  Brightness.light));
  }
  @override
  Widget build(BuildContext context) {
    _context=context;
    SearchBloc searchBloc = new SearchBloc();
    searchBloc.changeAll(true);
    searchBloc.changeFavorite(false);
    searchBloc.changeRestaurant(false);
    return BlocProvider<SearchBloc>(
      bloc: searchBloc,
      child: SafeArea(
        top: false,
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.025,
                  0.05,
                  0.1,
                  0.5,
                  0.9,
                  0.95,
                  0.99
                ],
                colors: [
                  Colors.black,
                  Colors.grey,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.grey,
                  Colors.black
                ]),
            //image: new DecorationImage(
            //image: new AssetImage('assets/images/gray.jpg'),
            //fit: BoxFit.cover,
            //),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 30, 10, 10),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                autocorrect: true,
                                onChanged: searchBloc.changeSearch,
                                decoration: InputDecoration(
                                  // errorText: snapshot.error,
                                  labelText: 'Search',

                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: Colors.white70,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50.0)),
                                    borderSide: BorderSide(
                                        color: AppTheme.primaryColor, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 23,
                                top: 9,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: AppTheme.primaryColor,
                                    size: 50,
                                  ),
                                  onPressed: () => searchBloc.changeClick(true),
                                ))
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              StreamBuilder<Object>(
                                  stream: searchBloc.allStream,
                                  builder: (context, snapshot) {
                                    return GestureDetector(
                                        onTap: () {
                                          searchBloc.changeAll(true);
                                          searchBloc.changeFavorite(false);
                                          searchBloc.changeRestaurant(false);
                                        },
                                        child: Container(
                                            child: Text(
                                          'Alle',
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                              color: snapshot.hasData &&
                                                      snapshot.data
                                                  ? AppTheme.primaryColor
                                                  : Colors.grey
                                                      .withOpacity(0.8)),
                                        )));
                                  }),
                              StreamBuilder<Object>(
                                  stream: searchBloc.restaurantStream,
                                  builder: (context, snapshot) {
                                    return IconButton(
                                        onPressed: () {
                                          searchBloc.changeFavorite(false);
                                          searchBloc.changeAll(false);
                                          searchBloc.changeRestaurant(true);
                                        },
                                        icon: Icon(Icons.location_on,
                                            size: 40,
                                            color: snapshot.hasData &&
                                                    snapshot.data
                                                ? AppTheme.primaryColor
                                                : Colors.grey
                                                    .withOpacity(0.8)));
                                  }),
                              StreamBuilder<Object>(
                                  stream: searchBloc.favoriteStream,
                                  builder: (context, snapshot) {
                                    return IconButton(
                                        onPressed: () {
                                          searchBloc.changeRestaurant(false);
                                          searchBloc.changeAll(false);
                                          searchBloc.changeFavorite(true);
                                        },
                                        icon: Icon(fav.favorite_like__2_,
                                            size: 50,
                                            color: snapshot.hasData &&
                                                    snapshot.data
                                                ? AppTheme.primaryColor
                                                : Colors.grey
                                                    .withOpacity(0.8)));
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 5.0,
                right: 5.0,
                child: CustomButtomNavigatior(showDialog: _ParentFunction,),
              ),
            ],
          ),
        )),
      ),
    );
  }

   _ParentFunction() async {
   

    await _showSelectionDialog(_context);
  }
BuildContext _context;
  Future<void> _showSelectionDialog(BuildContext context) async {
    print('im clicked hiiiii');
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Sign up"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/usersignup');
                  },
                ),
                Divider(
                  height: 1.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppTheme.primaryColor,
                  ),
                  title: Text("Log in"),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signin');
                  },
                )
              ],
            ),
          ));
        });
  }
}
