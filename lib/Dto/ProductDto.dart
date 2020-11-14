import 'package:foolife/Dto/CategoryDto.dart';
import 'package:foolife/Dto/RestaurantDto.dart';

import 'FileDto.dart';
import 'ProductExtraDto.dart';

class ProductDto {
  dynamic id;
  dynamic restaurantId;
  dynamic categoryId;
   dynamic likesCount;
  dynamic liked;
  int fileId;
  int typeId;
  String name;
  dynamic price;
  dynamic hidden;
  dynamic displayOrder;
  String details;
  String createdAt;
  String updatedAt;
  String content;
  FileDto file;
  RestaurantDto restaurantDto;

  CategoryDto category;
  List<ProductExtraDto> productExtra;

  ProductDto(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.fileId,
      this.typeId,
      this.name,
      this.price,
      this.hidden,
      this.displayOrder,
      this.createdAt,
      this.updatedAt,
      this.content,
      this.file,
      this.category,
      this.details,
      this.productExtra,
      this.restaurantDto});

  ProductDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    fileId = json['file_id'];
    typeId = json['type_id'];
    name = json['name'];
    price = json['price'];
    hidden = json['hidden'];
    displayOrder = json['displayOrder'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    details = json['details'];
    content = json['content'];
    likesCount=json ["likes_count"];
    liked=json ["liked"];
    file = json['file'] != null ? new FileDto.fromJson(json['file']) : null;
    restaurantDto = json['restaurant'] != null
        ? new RestaurantDto.fromJson(json['restaurant'])
        : null;
    category = json['category'] != null
        ? new CategoryDto.fromJson(json['category'])
        : null;
    if (json['product_extra'] != null) {
      productExtra = new List<ProductExtraDto>();
      json['product_extra'].forEach((v) {
        productExtra.add(new ProductExtraDto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    data['file_id'] = this.fileId;
    data['type_id'] = this.typeId;
    data['details'] = this.details;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hidden'] = this.hidden;
    data['displayOrder'] = this.displayOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content'] = this.content;
    if (this.file != null) {
      data['file'] = this.file.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}
