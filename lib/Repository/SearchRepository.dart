import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/CategorySearchDto.dart';
import 'package:foolife/Dto/ProductDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';
import 'package:foolife/Dto/RestaurantServicesDto.dart';
import 'package:foolife/Dto/SerachRestaurantsDto.dart';
import 'package:foolife/Dto/StatisticDto.dart';

import 'package:foolife/Dto/UserDto.dart';

import 'package:foolife/Models/ApiResponse.dart';
import 'package:foolife/Network/ApiProvider.dart';
import 'package:foolife/Screens/Restaurant/changeBackground.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  ApiProvider api = new ApiProvider();

  Future<SerachRestaurantsDto> serachRestaurants(
      String searchKey, double longitude, double latitude) async {
    try {
    var body = {"searchKey": searchKey, "longitude": longitude, "latitude": latitude};
      //print(restaurant.toJson());
      var response =
          await api.post('serachRestaurants', body);
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
          SerachRestaurantsDto serachRestaurantsDto = SerachRestaurantsDto.fromJson(data.data);
       

        print("doooone serach Restaurants");
        return serachRestaurantsDto;
      } else {
        print("erroooor serach Restaurants");
        return null;
      }
    } catch (e) {
      print("ohh shit serach Restaurants");
      print(e.toString());
    }
  }

}
