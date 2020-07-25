import 'package:foolife/Dto/CategoryDto.dart';

import 'FileDto.dart';

class ProductDto {
  dynamic id;
  dynamic restaurantId;
  dynamic categoryId;
  int fileId;
  String name;
  dynamic price;
  dynamic hidden;
  dynamic displayOrder;
  String createdAt;
  String updatedAt;
  FileDto file;
  CategoryDto category;

  ProductDto(
      {this.id,
      this.restaurantId,
      this.categoryId,
      this.fileId,
      this.name,
      this.price,
      this.hidden,
      this.displayOrder,
      this.createdAt,
      this.updatedAt,
      this.file,
      this.category
      });

  ProductDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    fileId = json['file_id'];
    name = json['name'];
    price = json['price'];
    hidden = json['hidden'];
    displayOrder = json['displayOrder'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    file = json['file'] != null ? new FileDto.fromJson(json['file']) : null;
    category = json['category'] != null ? new CategoryDto.fromJson(json['category']) : null;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    data['file_id'] = this.fileId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['hidden'] = this.hidden;
    data['displayOrder'] = this.displayOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.file != null) {
      data['file'] = this.file.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    return data;
  }
}
