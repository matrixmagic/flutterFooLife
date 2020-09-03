import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foolife/Dto/AuthDto.dart';
import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/CategorySearchDto.dart';
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

class RestaurantRepository {
  ApiProvider api = new ApiProvider();

  Future<RestaurantDto> add(
      String name,
      String address,
      String city,
      String street,
      String fax,
      String openTime,
      String closeTime,
      int accessible,
      int childfriendly,
      int gamepad,
      int wifi,
      int power,
      int pets,
      List<int> payments) async {
    try {
      RestaurantDto restaurant = new RestaurantDto();
      restaurant.name = name;
      restaurant.address = address;
      restaurant.city = city;
      restaurant.street = street;
      restaurant.fax = fax;
      restaurant.openTime = openTime;
      restaurant.closeTime = closeTime;
      RestaurantServicesDto restaurantServices = RestaurantServicesDto();
      restaurantServices.accessible = accessible;
      restaurantServices.childfriendly = childfriendly;
      restaurantServices.gamepad = gamepad;
      restaurantServices.wifi = wifi;
      restaurantServices.power = power;
      restaurantServices.pets = pets;
      restaurant.services = restaurantServices;
      List<int> x = null;
      restaurant.payments = payments;
      print(restaurant.toJson());
      var response = await api.post('restaurant', restaurant.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      final storage = new FlutterSecureStorage();
      if (data.success == true) {
        RestaurantDto restaurantDto = RestaurantDto.fromJson(data.data);

        var restaurantId = await storage.write(
            key: "_restaurantId", value: restaurantDto.id.toString());
        print("restuarant added ");
        return restaurantDto;
      } else {
        print("return nullll so no gooooooo");
        return null;
      }
    } catch (e) {
      print("exception on add resturant in repo");
      print(e.toString());
    }
  }

  Future<List<ProductDto>> getAllProductInCatgory(
      int categoryId, int restaurantId) async {
    try {
      CategorySearchDto categorySearchDto = new CategorySearchDto();
      categorySearchDto.categoryId = categoryId;
      categorySearchDto.restaurantId = restaurantId;

      //print(restaurant.toJson());
      var response =
          await api.post('getAllProductInCatgory', categorySearchDto.toJson());
      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        List<ProductDto> lst = new List<ProductDto>();
        data.data.forEach((v) {
          lst.add(new ProductDto.fromJson(v));
        });

        print("biiila");
        return lst;
      } else {
        print("return nullll so no gooooooo");
        return null;
      }
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<RestaurantDto>> gatAllResturants() async {
    try {
      var response = await api.get("gatAllResturants");

      print("status code" + response.statusCode.toString());
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
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<RestaurantDto>> getAllResturantPaging(
      int pageIndex, int pageSize) async {
    try {
      var body = {"pageIndex": pageIndex, "pageSize": pageSize};

      var response = await api.post("getAllResturantPaging", body);

      print("status code" + response.statusCode.toString());
      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("waka waka paaaage paaaage");
        List<RestaurantDto> lst = new List<RestaurantDto>();
        data.data.forEach((v) {
          lst.add(new RestaurantDto.fromJson(v));
        });

        print("biiila");
        return lst;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<RestaurantDto>> getAllResturantPaging2(
      List<dynamic> exceptIds, int pageSize) async {
    try {
      var body = {
        "exceptRestaurantIds": exceptIds.map((v) => v).toList(),
        "pageSize": pageSize
      };

      var response = await api.post("getAllResturantPagingRand", body);

      print("status code" + response.statusCode.toString());
      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("waka waka paaaage paaaage");
        List<RestaurantDto> lst = new List<RestaurantDto>();
        data.data.forEach((v) {
          lst.add(new RestaurantDto.fromJson(v));
        });

        print("biiila");
        return lst;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<CategoryDto>> getRestrantCategory(int restauratId) async {
    try {
      var response = await api.post(
          "getRestrantCategory", CategorySearchDto(restaurantId: restauratId));

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

  Future<bool> changeBackground(int fileId) async {
    try {
      var body = {
        "file_id": fileId,
      };

      var response = await api.post("restaurantChangeBackground", body);

      var data = ApiResponse.fromJson(json.decode(response.body));
      if (data.success == true) {
        print("the background is changed");
        return true;
      } else
        return false;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<List<StatisticDto>> getRestaurantStatistic(
      String chart_id, DateTime date, String time) async {
    var dt = date;
    var newFormat = DateFormat("yyyy-MM-dd");
    String updatedDt = newFormat.format(dt);

    try {
      var map = new Map<String, dynamic>();
      map['chart_id'] = chart_id;
      map['date'] = updatedDt;
      map['time'] = time;

      var response = await api.post("getResturantStatistic", map);

      print(response.body);

      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("Well done");
        List<StatisticDto> staticList = new List<StatisticDto>();
        data.data.forEach((v) {
          staticList.add(new StatisticDto.fromJson(v));
        });
        return staticList;
      } else
        return null;
    } catch (e) {
      print("something wrong in getResturantStatistic");
      print(e.toString());
      return e;
    }
  }

  Future<RestaurantDto> getRestaurantById(int id) async {
    try {
      var response = await api.get("getRestaurantById");
      var body = {
        "id": id,
      };
      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("get my restautent by Id");
        RestaurantDto restaurant = RestaurantDto.fromJson(data.data);
        return restaurant;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }

  Future<RestaurantDto> getMyResturant() async {
    try {
      var response = await api.get("getMyResturant");

      print("status code" + response.statusCode.toString());
      var data = ApiResponse.fromJson(json.decode(response.body));

      if (data.success == true) {
        print("get my restautent");
        RestaurantDto restaurant = RestaurantDto.fromJson(data.data);
        print("biiila");
        return restaurant;
      } else
        print("get nothing");
      return null;
    } catch (e) {
      print("ohh shit");
      print(e.toString());
    }
  }
}
