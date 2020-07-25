class CategorySearchDto {
  int categoryId;
  int restaurantId;

  CategorySearchDto({this.categoryId, this.restaurantId});

  CategorySearchDto.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}