import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/CategorySearchDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';

import 'package:foolife/Dto/UserDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';

class RestaurantRepository {
  ApiProvider api = new ApiProvider();


  Future<RestaurantDto> add(
     String name ,String address, String city,
      String street, String fax,String openTime,
      String closeTime , int accessible,int childfriendly,  
    int gamepad,int wifi,int power,int pets, 
    List<int> payments
      ) async {
    try {
      RestaurantDto restaurant = new RestaurantDto();
      restaurant.name=name;
      restaurant.address=address;
      restaurant.city=city;
      restaurant.street=street;
      restaurant.fax=fax;
      restaurant.openTime=openTime;
      restaurant.closeTime=closeTime;
      RestaurantServicesDto restaurantServices= RestaurantServicesDto();
      restaurantServices.accessible=accessible;
      restaurantServices.childfriendly=childfriendly;
      restaurantServices.gamepad=gamepad;
      restaurantServices.wifi=wifi;
      restaurantServices.power=power;
      restaurantServices.pets=pets;
      restaurant.services=restaurantServices;
        List<int> x = null;
      restaurant.payments=payments;
      print(restaurant.toJson());
      var response = await api.post('restaurant', restaurant.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        RestaurantDto restaurantDto = RestaurantDto.fromJson(data.data);

        var restaurantId =
            await storage.write(key: "_restaurantId", value: restaurantDto.id.toString());
            print("restuarant added ");
        return restaurantDto;
      } else{
        print("return nullll so no gooooooo");
      return null;
      }
    } catch (e) {
      print("exception on add resturant in repo");
      print(e.toString());
    }
  }
Future<List<ProductDto>> getAllProductInCatgory(int categoryId,int restaurantId ) async {
    try {
    CategorySearchDto categorySearchDto = new CategorySearchDto();
    categorySearchDto.categoryId= categoryId; 
      categorySearchDto.restaurantId= restaurantId;
      
      //print(restaurant.toJson());
      var response = await api.post('getAllProductInCatgory', categorySearchDto.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        

        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
        });
        

        print("biiila");
        return lst;
    
      } else{
        print("return nullll so no gooooooo");
      return null;
      }
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }
Future<List<RestaurantDto>>  gatAllResturants() async {
  try{
 var response = await api.get("gatAllResturants");

      var data = ApiResponse.fromJson(json.decode(response.body));
  
      if (data.success == true) {
        print("waka waka");
        List<RestaurantDto> lst = new List<RestaurantDto>();
        data.data.forEach((v) {
          lst.add(new RestaurantDto.fromJson(v));
        });
        

        print("biiila");
        return lst;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }


}
Future<List<CategoryDto>>  getRestrantCategory(int restauratId) async {
  try{

    
 var response = await api.post("getRestrantCategory",CategorySearchDto(restaurantId: restauratId));

      var data = ApiResponse.fromJson(json.decode(response.body));
  
      if (data.success == true) {
        print("waka waka");
        List<CategoryDto> lst = new List<CategoryDto>();
        data.data.forEach((v) {
          lst.add(new CategoryDto.fromJson(v));
        });
        

        print("biiila");
        return lst;
      } else
        return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }


}

}



    
