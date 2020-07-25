import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/CustomProductWidget.dart';
import 'package:foolife/Widget/MenuBar.dart';
import 'package:foolife/Widget/custom_buttom_navigatior.dart';

class CategoriesScreen extends StatelessWidget {
  int restaurantid;
  int categoryId;

  CategoriesScreen({this.categoryId,this.restaurantid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body : FutureBuilder(
        future: RestaurantRepository().getAllProductInCatgory(categoryId, restaurantid),
         builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.connectionState ==ConnectionState.done){
                List<ProductDto> products= snapshot.data;

                return Stack(
                  children: <Widget>[

                    
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {

                        return CustomProductWidget(
                          backgroundImage: products[index].file.path,
                          product: products[index],
                          restaurantid: restaurantid,
                          extention: products[index].file.extension,
                         //cateogries: products[index].categories,
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
          child: Container( child: CustomButtomNavigatior(),)
        ),
                        
      FutureBuilder(
        future: RestaurantRepository().getRestrantCategory(restaurantid),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
          return Positioned(bottom:40 , child: Container(height:40,width: MediaQuery.of(context).size.width ,child: MenuBar(items:snapshot.data ,) ));
          }
          else
          return Container();
        }

      ),

       
      

      

                  ],
                );}else{
              
                  
                    return Container();


                }

                }
              
        
      ),
    );
  }
}