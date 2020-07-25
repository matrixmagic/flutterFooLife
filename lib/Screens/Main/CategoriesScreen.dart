import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Repository/RestaurantRepository.dart';
import 'package:foolife/Widget/CustomMainScreenWiget.dart';
import 'package:foolife/Widget/CustomProductWidget.dart';

class CategoriesScreen extends StatelessWidget {
  int restaurantid;
  int categoryId;

  CategoriesScreen({this.categoryId,this.restaurantid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RestaurantRepository().getAllProductInCatgory(categoryId, restaurantid),
       builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.connectionState ==ConnectionState.done){
              List<ProductDto> products= snapshot.data;

              return Swiper(
                itemBuilder: (BuildContext context, int index) {

                  return CustomProductWidget(
                    backgroundImage: products[index].file.path,
                    productName: products[index].name,
                    restaurantid: restaurantid,
                    extention: products[index].file.extension,
                   //cateogries: products[index].categories,
                  );
                },
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                scale: 1.0,
              );}else{
              return Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return CustomProductWidget(
                    backgroundImage: "https://www.insperry.com/Insperry/public/uploads/files/store/07_19_2020_12_40_75restaurent1.jpg",
                    productName: "koko" ,
                    restaurantid: restaurantid,
                    extention: "ddsfs",
                  );
                },
                itemCount: 1,
                scrollDirection: Axis.vertical,
                scale: 1.0,
              );


              }

              }
            
      
    );
  }
}