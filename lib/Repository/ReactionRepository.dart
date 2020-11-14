import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/CategorySearchDto.dart';
import 'package:foolife/Dto/FavouriteDto.dart';
import 'package:foolife/Dto/LikeDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';
import 'package:foolife/Dto/StatisticDto.dart';

import 'package:foolife/Dto/UserDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';
import 'package:foolife/Screens/Restaurant/changeBackground.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ReactionRepository {
  ApiProvider api = new ApiProvider();

  Future<LikeDto> like(
      int productId) async {
    try {
     
      var body = {
        "product_id": productId
      };

      var response = await api.post('customerLike', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      print(data.data.toString());
     
      if (data.success == true) {
        LikeDto likeDto = LikeDto.fromJson(data.data);

        print("product liked or unliked");
        return likeDto;
      } else {
        print("return nullll so no gooooooo");
        return null;
      }
    } catch (e) {
      print("exception on add resturant in repo");
      print(e.toString());
        return null;
    }
  }


 Future<FavouriteDto> favourite(
      int restaurantId) async {
    try {
     
      var body = {
        "restaurant_id": restaurantId
      };

      var response = await api.post('customerFavourite', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      print(data.data.toString());
     
      if (data.success == true) {
        FavouriteDto favouriteDto = FavouriteDto.fromJson(data.data);

        return favouriteDto;
      } else {
        print("return nullll so no gooooooo");
        return null;
      }
    } catch (e) {
      print("exception on add resturant in repo");
      print(e.toString());
        return null;
    }
  }
  
}
