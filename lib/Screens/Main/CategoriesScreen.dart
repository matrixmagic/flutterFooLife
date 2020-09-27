import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Bloc/video/VideoBloc.dart';

import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/CustomProductWidget.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';

import '../../AppTheme.dart';

class CategoriesScreen extends StatefulWidget {
  int restaurantid;
  int categoryId;

  CategoriesScreen({this.categoryId, this.restaurantid}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Function stopVideo;

  List<ProductDto> products;
VideoBloc videoBloc = new VideoBloc();

  Future<void> getAllProduct()
  async {
    var prods = await RestaurantRepository()
              .getAllProductInCatgory(widget.categoryId, widget.restaurantid);
              setState(() {
                products = prods;
              });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllProduct();

  }
  @override
  Widget build(BuildContext context) {
    _context=context;
    return Scaffold(
      body:products!=null? Stack(
                children: <Widget>[
                  Swiper(onIndexChanged: (i) async {
                   await  videoBloc.disposeAllVideosleave();
                  },
                    itemBuilder: (BuildContext context, int index) {
                      return CustomProductWidget(
                      
                        product: products[index],
                       videoBloc: videoBloc,
                       forChannel: false,
                        
                      );
                    },
                    itemCount: products.length,
                    scrollDirection: Axis.vertical,
                    scale: 1.0,
                  ),
                  Positioned(
                      bottom: 0,
                      left: 5.0,
                      right: 5.0,
                      child: Container(
                        child: CustomButtomNavigatior(videoBloc: videoBloc ),
                      )),
                  FutureBuilder(
                      future: RestaurantRepository()
                          .getRestrantCategory(widget.restaurantid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Positioned(
                              bottom: 40,
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  child: MenuBar(
                                    videoBloc: videoBloc,
                                      items: snapshot.data,
                                      isProduct: true,
                                      lastCategoryId: widget.categoryId)));
                        } else
                          return Container();
                      }),
                ],
              ):Container());
            
      
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
