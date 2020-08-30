import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';
import 'package:foolife/Widget/top_channel_bar.dart';

import '../../AppTheme.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override


  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
restaurents=new List<RestaurantDto>();
getAllResturants();

  }
  List<RestaurantDto> restaurents;
  Future<void> getAllResturants()
  async {
   var x= await RestaurantRepository().getAllResturantPaging(pageIndex,4);


setState(() {
  restaurents.addAll(x);
});
  }

  BuildContext _context;

  int pageIndex = 0;

  getMore() async {
          pageIndex++;
                    var x= await RestaurantRepository().getAllResturantPaging(pageIndex,4);
                    print("ohhhh africaaaa");
                    setState(() {
                        restaurents.addAll(x);
                      
                    });
                  print(restaurents.first.name +"   "+restaurents.last.name);
  }


  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        
             restaurents.length>0?

                 Container(
                   height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
                   child: ListView.builder(
                     
                
                    itemBuilder: (BuildContext context, int index)  {
                         if(index==restaurents.length-2)
                      {
                     getMore();
                      }
                    
                     
                      
                      return CustomMainScreenWiget(
                        restauranDto: restaurents[index],
                        cateogries: restaurents[index].categories,
                      );
                    },
                    itemCount: restaurents.length,
                    scrollDirection: Axis.vertical,
                

                    
                ),
                 ):Container(),
             
         
        Positioned(
          bottom: 0,
          left: 5.0,
          right: 5.0,
          child: CustomButtomNavigatior(
            showDialog: _ParentFunction,
          ),
        ),
        Positioned(top: 50, left: 5.0, right: 5.0, child: Top_channel_bar()),
      ],
    ));
  }

  _ParentFunction() async {
    print('im clickedxxxx hiiiii');

    await _showSelectionDialog(_context);
  }

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
