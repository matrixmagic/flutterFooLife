import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
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

      restaurant.payments=payments;
      var response = await api.post('restaurant', restaurant.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        RestaurantDto restaurantDto = RestaurantDto.fromJson(data.data);
        var restaurantId =
            await storage.write(key: "_restaurantId", value: restaurantDto.id.toString());
        return restaurantDto;
      } else
      return null;
    } catch (e) {
      print(e.toString());
    }
  }

    
}
