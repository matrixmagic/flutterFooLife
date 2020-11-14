import 'dart:ffi';

import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/PostDto.dart';
import 'package:foolife/Dto/UserDto.dart';

import 'FileDto.dart';
import 'PaymentsMethod.dart';
import 'RestaurantServicesDto.dart';

class RestaurantDto {
  dynamic  id;
  dynamic userId;
  String name;
  String city;
  String address;
  String street;
  String fax;
  String openTime;
  String closeTime;
  dynamic longitude;
  dynamic latitude;
  dynamic favourite;
  dynamic favsCount;
  String createdAt;
  String updatedAt;
  RestaurantServicesDto services;
  PostDto post;

  UserDto user;
  List<int> payments;
  List<int> currencies;
  List<int> games;
  FileDto file;
  List<CategoryDto>  categories;
  List<CategoryDto>  mainCategories;
  List<PaymentsMethod> paymentsMethod;

  RestaurantDto(
      {this.id,
      this.userId,
      this.name,
      this.city,
      this.address,
      this.street,
      this.fax,
      this.openTime,
      this.closeTime,
      this.longitude,
      this.latitude,
      this.createdAt,
      this.updatedAt,
      this.services,
      this.paymentsMethod,
      this.post,
      this.file});

  RestaurantDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    city = json['city'];
    address = json['address'];
    street = json['street'];
    fax = json['fax'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    longitude = json['longitude'];
    latitude = json['latitude'];
     favourite = json['favourite'];
      favsCount = json['favs_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    services = json['services'] != null
        ? new RestaurantServicesDto.fromJson(json['services'])
        : null;
        post = json['post'] != null
        ? new PostDto.fromJson(json['post'])
        : null;
    user = json['user'] != null
        ? new UserDto.fromJson(json['user'])
        : null;

 

   
    payments =json['payments'] != null? json['payments'].cast<int>():null;
  

 
    file = json['file'] != null ? new FileDto.fromJson(json['file']) : null;
    if (json['categories'] != null) {
      categories = new List<CategoryDto>();
      json['categories'].forEach((v) {
        categories.add(new CategoryDto.fromJson(v));
      });
    }
    if (json['main_categories'] != null) {
      mainCategories = new List<CategoryDto>();
      json['main_categories'].forEach((v) {
        mainCategories.add(new CategoryDto.fromJson(v));
      });
    }

    if (json['payments_method'] != null) {
     paymentsMethod = new List<PaymentsMethod>();
      json['payments_method'].forEach((v) {
        paymentsMethod.add(new PaymentsMethod.fromJson(v));
      });
    }

    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['city'] = this.city;
    data['address'] = this.address;
    data['street'] = this.street;
    data['fax'] = this.fax;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.services != null) {
      data['services'] = this.services.toJson();
    }
 
     if (this.payments != null) {
      data['payments'] = this.payments.map((v) => v).toList();
    }
   if(this.currencies != null)
    data['currencies'] = this.currencies;
    if(this.games !=null)
    data['games'] = this.games;
    return data;
  }
}