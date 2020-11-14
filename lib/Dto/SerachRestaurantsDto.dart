import 'package:foolife/Dto/ProductDto.dart';

import 'RestaurantDto.dart';

class SerachRestaurantsDto {
  List<RestaurantDto> restaurants;
  List<ProductDto> products;

  SerachRestaurantsDto({this.restaurants, this.products});

  SerachRestaurantsDto.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<RestaurantDto>();
      json['restaurants'].forEach((v) {
        restaurants.add(new RestaurantDto.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = new List<ProductDto>();
      json['products'].forEach((v) {
        products.add(new ProductDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}