class CategoryDto {
  dynamic id;
  dynamic parentCategoryId;
  dynamic restaurantId;
  String name;
  dynamic displayOrder;
  String createdAt;
  String updatedAt;

  CategoryDto(
      {this.id,
      this.parentCategoryId,
      this.restaurantId,
      this.name,
      this.displayOrder,
      this.createdAt,
      this.updatedAt});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentCategoryId = json['parentCategory_id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    displayOrder = json['displayOrder'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parentCategory_id'] = this.parentCategoryId;
    data['restaurant_id'] = this.restaurantId;
    data['name'] = this.name;
    data['displayOrder'] = this.displayOrder;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}