import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/AppTheme.dart';
import 'package:foolife/Bloc/topbarBloc.dart';
import 'package:foolife/Repository/AuthRepository.dart';
import 'package:foolife/Widget/topBar.dart';

class Top_channel_bar extends StatelessWidget {
  @override
  //FlutterSecureStorage storage = new FlutterSecureStorage();
  Widget build(BuildContext context) {
    TopBarBloc topBarBloc = new TopBarBloc();
    topBarBloc.changeFirst(true);
    topBarBloc.changeSecond(false);
    topBarBloc.changeThird(false);
    topBarBloc.changeFourth(false);

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 40.0,
                spreadRadius: 1.0,
              ),
            ]),
            child: StreamBuilder(
                stream: topBarBloc.firstStream,
                builder: (context, snapshot) {
                  return IconButton(
                    onPressed: () {
                      topBarBloc.changeFirst(true);
                      topBarBloc.changeSecond(false);
                      topBarBloc.changeThird(false);
                      topBarBloc.changeFourth(false);
                    },
                    icon: Icon(TopBar.castle_emblem,
                        color: snapshot.hasData && snapshot.data
                            ? AppTheme.notWhite.withOpacity(0.9)
                            : Colors.grey.withOpacity(0.8)),
                    //  onPressed: openCreatePostScreen,
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 40.0,
                spreadRadius: 1.0,
              ),
            ]),
            child: StreamBuilder(
                stream: topBarBloc.secondStream,
                builder: (context, snapshot) {
                  return IconButton(
                    onPressed: () {
                      topBarBloc.changeFirst(false);
                      topBarBloc.changeSecond(true);
                      topBarBloc.changeThird(false);
                      topBarBloc.changeFourth(false);
                    },
                    icon: Icon(TopBar.restaurant,
                        color: snapshot.hasData && snapshot.data
                            ? AppTheme.notWhite.withOpacity(0.9)
                            : Colors.grey.withOpacity(0.8)),
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 40.0,
                spreadRadius: 1.0,
              ),
            ]),
            child: StreamBuilder(
                stream: topBarBloc.thirdStream,
                builder: (context, snapshot) {
                  return IconButton(
                    onPressed: () {
                      topBarBloc.changeFirst(false);
                      topBarBloc.changeSecond(false);
                      topBarBloc.changeThird(true);
                      topBarBloc.changeFourth(false);
                    },
                    icon: Icon(Icons.fastfood,
                        color: snapshot.hasData && snapshot.data
                            ? AppTheme.notWhite.withOpacity(0.9)
                            : Colors.grey.withOpacity(0.8)),
                    //  onPressed: openCreatePostScreen,
                  );
                }),
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.7),
                blurRadius: 40.0,
                spreadRadius: 1.0,
              ),
            ]),
            child: StreamBuilder(
                stream: topBarBloc.fourthtStream,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      topBarBloc.changeFirst(false);
                      topBarBloc.changeSecond(false);
                      topBarBloc.changeThird(false);
                      topBarBloc.changeFourth(true);
                    },
                    child: Container(
                      child: Text(
                        "STORY'S",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: snapshot.hasData && snapshot.data
                                ? AppTheme.notWhite.withOpacity(0.9)
                                : Colors.grey.withOpacity(0.8),
                            fontSize: 19),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
