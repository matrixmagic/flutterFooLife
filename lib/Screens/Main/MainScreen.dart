import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/ProductRepository.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/CustomProductWidget.dart';
import 'package:foolife/Widget/CustomRestaurantScreenWiget.dart';
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
    restaurents = new List<RestaurantDto>();
     foods = new List<ProductDto> ();
 drinks = new List<ProductDto> ();

    getAllResturants();

    getAllFoodsPaging();

    getAllDrinksPaging();
swiperControl=new SwiperController();
    
  }

  List<RestaurantDto> restaurents;
  List<ProductDto> foods;
  List<ProductDto> drinks;
  SwiperController swiperControl;

  int restaurentsPageIndex = 0;
  int foodsPageIndex = 0;
  int drinksPageIndex = 0;
  int pageSize = 10;
   int lastSelectedChannel = 2;


  Future<void> getAllResturants() async {
    var data = await RestaurantRepository()
        .getAllResturantPaging(restaurentsPageIndex, pageSize);

    setState(() {
      restaurents.addAll(data);
    });
  }

  Future<void> getAllFoodsPaging() async {
    var data =
        await ProductRepository().getAllFoodsPaging(foodsPageIndex, pageSize);

    setState(() {
      foods.addAll(data);
    });
  }

  Future<void> getAllDrinksPaging() async {
    var data =
        await ProductRepository().getAllDrinksPaging(drinksPageIndex, pageSize);

    setState(() {
      drinks.addAll(data);
    });
  }

  BuildContext _context;

  getMore() async {
    var data;

    if (lastSelectedChannel == 2) {
      restaurentsPageIndex++;
      data = await RestaurantRepository()
          .getAllResturantPaging(restaurentsPageIndex, pageSize);
      setState(() {
        restaurents.addAll(data);
      });
    } else if (lastSelectedChannel == 31) {
      foodsPageIndex++;
      data =
          await ProductRepository().getAllFoodsPaging(foodsPageIndex, pageSize);
      setState(() {
        foods.addAll(data);
      });
    } else if (lastSelectedChannel == 32) {
      drinksPageIndex++;
      data = await ProductRepository()
          .getAllDrinksPaging(drinksPageIndex, pageSize);
      setState(() {
        drinks.addAll(data);
      });
    }
  }

 

  void selectChannel(int channel) {
    setState(() {
      lastSelectedChannel = channel;
    });

    swiperControl.move(0);  }

  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        lastSelectedChannel==2 && 
        restaurents.length > 0
            ? Swiper(controller: swiperControl,
              onIndexChanged: (int index){
                  if (lastSelectedChannel == 2 &&
                    index == restaurents.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 31 &&
                    index == foods.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 32 &&
                    index == drinks.length - 2) {
                    getMore();
                  }
              },
                itemBuilder: (BuildContext context, int index) {
                
                  if (lastSelectedChannel == 2) {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                  else  if (lastSelectedChannel == 31) {
                    return CustomProductWidget(

                      forChannel: true,
                      product: foods[index],
                      changeChannel:selectChannel 
                    ,
                    
                    );
                  }
                  else  if (lastSelectedChannel == 32) {
                    return CustomProductWidget(

                      forChannel: true,
                      product: drinks[index],
                       changeChannel:selectChannel 
                    
                    );
                  }
                  else {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                },
                itemCount: restaurents.length,
                scrollDirection: Axis.vertical,
              )
            : lastSelectedChannel == 32 && drinks.length > 0 ? Swiper(
              controller: swiperControl,
              onIndexChanged: (int index){
                  if (lastSelectedChannel == 2 &&
                    index == restaurents.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 31 &&
                    index == foods.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 32 &&
                    index == drinks.length - 2) {
                    getMore();
                  }
              },
                itemBuilder: (BuildContext context, int index) {
                
                  if (lastSelectedChannel == 2) {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                  else  if (lastSelectedChannel == 31) {

                    return CustomProductWidget(

                      forChannel: true,
                      product: foods[index],
                      isDrink: false,

                       changeChannel:selectChannel 
                    
                    );
                  }
                  else  if (lastSelectedChannel == 32) {
                    return CustomProductWidget(

                      forChannel: true,
                      product: drinks[index],
                       changeChannel:selectChannel ,
                      isDrink: true,

                    
                    );
                  }
                  else {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                },
                itemCount: drinks.length,
                scrollDirection: Axis.vertical,
              ):lastSelectedChannel == 31 && foods.length > 0 ? Swiper(
                controller: swiperControl,
              onIndexChanged: (int index){
                  if (lastSelectedChannel == 2 &&
                    index == restaurents.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 31 &&
                    index == foods.length - 2) {
                    getMore();
                  }
                  else  if (lastSelectedChannel == 32 &&
                    index == drinks.length - 2) {
                    getMore();
                  }
              },
                itemBuilder: (BuildContext context, int index) {
                
                  if (lastSelectedChannel == 2) {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                  else  if (lastSelectedChannel == 31) {

                    return CustomProductWidget(

                      forChannel: true,
                      product: foods[index],
                       changeChannel:selectChannel ,
                      isDrink: false,

                    
                    );
                  }
                  else  if (lastSelectedChannel == 32) {
                    return CustomProductWidget(

                      forChannel: true,
                      product: drinks[index],
                     changeChannel:selectChannel ,
                      isDrink: true,

                    );
                  }
                  else {
                    return CustomRestaurantScreenWiget(
                      restauranDto: restaurents[index],
                      cateogries: restaurents[index].categories,
                    );
                  }
                },
                itemCount: foods.length,
                scrollDirection: Axis.vertical,
              ): Container(),
        Positioned(
          bottom: 0,
          left: 5.0,
          right: 5.0,
          child: CustomButtomNavigatior(
            showDialog: _ParentFunction,
          ),
        ),
        Positioned(
            top: 50,
            left: 5.0,
            right: 5.0,
            child: Top_channel_bar(
              changeChannel: selectChannel,
              selectedChannel: lastSelectedChannel,
            )),
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
